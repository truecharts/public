#!/usr/local/bin/bash
# This file contains the install script for plex

iocage exec plex mkdir -p /usr/local/etc/pkg/repos

# Change to to more frequent FreeBSD repo to stay up-to-date with plex more.
# shellcheck disable=SC2154
cp "${SCRIPT_DIR}"/blueprints/plex/includes/FreeBSD.conf /mnt/"${global_dataset_iocage}"/jails/"$1"/root/usr/local/etc/pkg/repos/FreeBSD.conf


# Check if datasets for media librarys exist, create them if they do not.
# shellcheck disable=SC2154
createmount "$1" "${global_dataset_media}" /mnt/media
createmount "$1" "${global_dataset_media}"/movies /mnt/media/movies
createmount "$1" "${global_dataset_media}"/music /mnt/media/music
createmount "$1" "${global_dataset_media}"/shows /mnt/media/shows

# Create plex ramdisk if specified
# shellcheck disable=SC2154
if [ -z "${plex_ramdisk}" ]; then
	echo "no ramdisk specified for plex, continuing without ramdisk"
else
	iocage fstab -a "$1" tmpfs /tmp_transcode tmpfs rw,size="${plex_ramdisk}",mode=1777 0 0
fi

iocage exec "$1" chown -R plex:plex /config

# Force update pkg to get latest plex version
iocage exec "$1" pkg update
iocage exec "$1" pkg upgrade -y

# Add plex user to video group for future hw-encoding support
iocage exec "$1" pw groupmod -n video -m plex

# Run different install procedures depending on Plex vs Plex Beta
# shellcheck disable=SC2154
if [ "$plex_beta" == "true" ]; then
	echo "beta enabled in config.yml... using plex beta for install"
	iocage exec "$1" sysrc "plexmediaserver_plexpass_enable=YES"
	iocage exec "$1" sysrc plexmediaserver_plexpass_support_path="/config"
	iocage exec "$1" chown -R plex:plex /usr/local/share/plexmediaserver-plexpass/
	iocage exec "$1" service plexmediaserver_plexpass restart
else
	echo "beta disabled in config.yml... NOT using plex beta for install"
	iocage exec "$1" sysrc "plexmediaserver_enable=YES"
	iocage exec "$1" sysrc plexmediaserver_support_path="/config"
	iocage exec "$1" chown -R plex:plex /usr/local/share/plexmediaserver/
	iocage exec "$1" service plexmediaserver restart
fi

echo "Finished installing plex"