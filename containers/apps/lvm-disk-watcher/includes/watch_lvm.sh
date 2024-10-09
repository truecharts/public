#!/bin/bash
set -e

config_file="/config/disk-config"
node_name="${NODE_NAME}"
VG_NAME="topolvm_vg"

while true; do
  # Function to list all disks
  list_disks() {
    echo "Executing list_disks function..."
    lsblk -dno NAME,TYPE,SIZE || echo "lsblk command failed with exit code $?"
  }

  echo "Updating LVM setup."

  # Print current PVs, VGs and LVs
  echo "Current Physical Volumes:"
  pvscan
  echo "Current Volume Groups:"
  vgs
  echo "Current Logical Volumes:"
  lvs

  # Print list of disks
  list_disks

  # Read configuration for the current node
  if [ -f "$config_file" ]; then
    echo "Config file found, contents:"
    cat "$config_file"
    # Fetch disks to watch for the current node
    watch_disks=$(grep "^$node_name:" "$config_file" | cut -d ':' -f 2- | xargs)

    echo "Configuration found for node $node_name: $watch_disks"

    if [ -z "$watch_disks" ]; then
      echo "No configuration found for node $node_name. Sleeping."
    elif [ "$watch_disks" == "all" ]; then
      echo "All disks configured for node $node_name."
      watch_disks=$(lsblk -dno NAME,TYPE | grep -v -E 'loop|rom|raid|dm|crypt|tape|usb|floppy|bcm2835_sdhost' | awk '$2=="disk" {print "/dev/" $1}')
    elif [ "$watch_disks" == "none" ]; then
      echo "No disks configured for node $node_name. Sleeping."
      watch_disks=""
    fi

    # Process each disk configuration for the node
    for disk in $watch_disks; do
      # Check if the disk is empty
      if ! lsblk -n "$disk" | grep -q part; then
        echo "Disk $disk has no partitions. Checking for LVM and filesystem signatures."

        # Check for existing LVM metadata
        if pvs "$disk" &>/dev/null; then
          echo "Disk $disk is already part of an LVM setup. Skipping."
          continue
        fi

        # Check for filesystem signatures
        if wipefs -n "$disk" | grep -q offset; then
          echo "Disk $disk has filesystem signatures. Skipping."
          continue
        fi

        echo "Disk $disk is empty and has no LVM or filesystem signatures. Setting up LVM."

        # Wipe existing LVM metadata (just in case)
        pvremove -ff -y "$disk" || echo "No existing LVM metadata to remove on $disk."

        # Wipe filesystem signatures
        wipefs -a "$disk"

        # Create LVM PV
        pvcreate -ff "$disk"

        # Create VG with the disk name (remove /dev/ prefix)
        vgcreate "${VG_NAME}" "$disk"

        # Create a thin pool (disabled auto metadata update backup), it will create a warning for this
        lvcreate -l 100%FREE --chunksize 256 -T -A n -n topolvm_thin ${VG_NAME}

        # /sbin/dmeventd: stat failed: No such file or directory. WARNING: Failed to monitor ${VG_NAME}/topolvm_thin.
        # will be output as well. When somebody have a fix feel fry to add.

      else
        echo "Disk $disk has partitions. Skipping."
      fi
    done

    # Check if the VG is already active
    vg_active=$(vgdisplay "$VG_NAME" | grep "VG Status" | awk '{print $3}')

    if [ "$vg_active" == "available" ]; then
        echo "Volume group $VG_NAME is already active."
    else
        echo "Activating volume group $VG_NAME..."
        vgchange -ay "$VG_NAME" || echo "Failed to activate volume group $VG_NAME."
        if [ $? -eq 0 ]; then
            echo "Volume group $VG_NAME has been activated."
        fi
    fi
  else
    echo "Configuration file not found. Exiting."
    exit 1
  fi


  echo "sleeping 60 seconds"
  sleep 60  # Sleep for 1 minute before checking again
done
