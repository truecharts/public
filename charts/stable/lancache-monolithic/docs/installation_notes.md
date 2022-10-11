# Installation Notes

Clients like Steam, Battle.net, etc sends requests to port 80/443.
In case you don't want to use traefik in front of this app, you need to change the ports.

- `Service` -> `Main` -> `Port`: **80**
- `Service` -> `https` -> `Port`: **443**

:::danger

Doing this will break Traefik and we do NOT recommend it.
Also, you have to make sure that you do NOT have any other service on these ports.
Like TrueNAS Scale WebUI.

:::

## Lancache-dns

- It's highly recommended to also install the `lancache-dns` chart along side the monolithic chart.

## Prefill Tools

- You can run the Prefill tools directly inside the chart's shell.
  - [SteamPrefill](https://github.com/tpill90/steam-lancache-prefill)
  - [BattleNetPrefill](https://github.com/tpill90/battlenet-lancache-prefill)

- In order for those tools to function you will need to install a apt pkg called `unzip`. This pkg will not persist between updates. It will need to be reinstalled before updating the tools everytime.

- The following scripts are examples, but can be used to not only install them but also update them too. The scripts are a bit modified from the original that comes from [SteamPrefill](https://github.com/tpill90/steam-lancache-prefill/blob/master/scripts/update.sh).

:::danger

Always be cautious when running unkown scripts and read them over before executing!

:::

### SteamPrefill

- This is a small modified update script from SteamPrefill to install the tool.
  - Add this script to the `/data` dir and name it for ex: `install_steam.sh`.
  - run this command on the script `chmod +x install_steam.sh` to be able to execute it from the shell.
  - This script will create a new dir called `Steam` and grab the latest zip from `tpill90` repo for SteamPrefill and auto chmod +x for you.
  - Then `cd Steam` if still in `/data` and execute `./SteamPrefill select-apps`.
  - If you are not login into Steam yet, the tool will ask for:
    - Username.
    - Password.
    - Steam Guard Code(if enabled on the account).

```shell
#!/bin/bash
Cyan='\033[0;36m'
RED='\033[0;31m'
Yellow='\033[0;33m'
NC='\033[0m' # No Color

cd /data

# make steam dir
if [ -d "Steam" ] 
then
    echo "Directory `Steam` exists." 
else
    echo "Creating Steam dir"
 mkdir Steam
fi

cd Steam

# Checking for required software
if ! [ -x "$(command -v curl)" ]; then
  echo -e "${RED}Required software curl is not installed.${NC}" >&2
  exit 1
fi
if ! [ -x "$(command -v jq)" ]; then
  echo -e "${RED}Required software jq is not installed.${NC}" >&2
  exit 1
fi
if ! [ -x "$(command -v unzip)" ]; then
  echo -e "${RED}Required software unzip is not installed.${NC}" >&2
  exit 1
fi

# Getting latest version tag
echo -e "${Yellow} Checking for latest version ${NC}"
VERSION_API_STEAM="https://api.github.com/repos/tpill90/steam-lancache-prefill/releases"
LATEST_TAG_STEAM=$(curl -s $VERSION_API_STEAM | jq -r '.[0].tag_name' | cut -c 2-)

if [ -z "${LATEST_TAG_STEAM}" ]; then
    echo -e " ${RED}Something went wrong, unable to get latest version!${NC}"
    exit 1
fi
echo -e " Found latest version : ${Cyan} ${LATEST_TAG_STEAM} ${NC}"

# Downloading latest version
echo -e "${Yellow} Downloading... ${NC}"
DOWNLOAD_URL_STEAM="https://github.com/tpill90/steam-lancache-prefill/releases/download/v${LATEST_TAG_STEAM}/SteamPrefill-${LATEST_TAG_STEAM}-linux-x64.zip"
wget -q -nc --show-progress --progress=bar:force:noscroll $DOWNLOAD_URL_STEAM

# Unzip
echo -e "${Yellow} Unzipping... ${NC}"
unzip -q -j -o SteamPrefill-${LATEST_TAG_STEAM}-linux-x64.zip

# Cleanup
rm SteamPrefill-${LATEST_TAG_STEAM}-linux-x64.zip
chmod +x SteamPrefill

if [ -f update.sh ] 
then
    chmod +x update.sh
else
    echo update file doesnt exists.
fi

echo -e " ${Cyan} Complete! ${NC}"
```

### BattleNetPrefill

- This is a small modified update script from SteamPrefill to install BattleNetPrefill.
  - Add this script to the `/data` dir and name it for ex: `install_battlenet.sh`.
  - run this command on the script `chmod +x install_battlenet.sh` to be able to execute it from the shell.
  - This script will create a new dir called `BattleNet` and grab the latest zip from `tpill90` repo for BattlenetPrefill and auto chmod +x for you.
  - Then `cd BattleNet` if still in `/data` and execute `./BattleNetPrefill -h`.

- BattleNetPrefill doesnt require an account. But the command to prefill are a bit different.
- In order to prefill a specific game. you need to run this command first `./BattleNetPrefill list-products` to get the product ID.
- Then you can run `/BattleNetPrefill prefill -p PRODUCT_ID`.

```shell
#!/bin/bash
Cyan='\033[0;36m'
RED='\033[0;31m'
Yellow='\033[0;33m'
NC='\033[0m' # No Color

cd /data

# make BattleNet dir
if [ -d "BattleNet" ] 
then
    echo "Directory `BattleNet` exists." 
else
    echo "Creating BattleNet dir"
mkdir BattleNet
fi

cd BattleNet

# Checking for required software
if ! [ -x "$(command -v curl)" ]; then
  echo -e "${RED}Required software curl is not installed.${NC}" >&2
  exit 1
fi
if ! [ -x "$(command -v jq)" ]; then
  echo -e "${RED}Required software jq is not installed.${NC}" >&2
  exit 1
fi
if ! [ -x "$(command -v unzip)" ]; then
  echo -e "${RED}Required software unzip is not installed.${NC}" >&2
  exit 1
fi

# Getting latest version tag
echo -e "${Yellow} Checking for latest version ${NC}"
VERSION_API_BATTLENET="https://api.github.com/repos/tpill90/battlenet-lancache-prefill/releases"
LATEST_TAG_BATTLENET=$(curl -s $VERSION_API_BATTLENET | jq -r '.[0].tag_name' | cut -c 2-)

if [ -z "${LATEST_TAG_BATTLENET}" ]; then
    echo -e " ${RED}Something went wrong, unable to get latest version!${NC}"
    exit 1
fi
echo -e " Found latest version : ${Cyan} ${LATEST_TAG_BATTLENET} ${NC}"

# Downloading latest version
echo -e "${Yellow} Downloading... ${NC}"
DOWNLOAD_URL_BATTLENET="https://github.com/tpill90/battlenet-lancache-prefill/releases/download/v${LATEST_TAG_BATTLENET}/BattleNetPrefill-${LATEST_TAG_BATTLENET}-linux-x64.zip"
wget -q -nc --show-progress --progress=bar:force:noscroll $DOWNLOAD_URL_BATTLENET

# Unzip
echo -e "${Yellow} Unzipping... ${NC}"
unzip -q -j -o BattleNetPrefill-${LATEST_TAG_BATTLENET}-linux-x64.zip

# Cleanup
rm BattleNetPrefill-${LATEST_TAG_BATTLENET}-linux-x64.zip
chmod +x BattleNetPrefill

if [ -f update.sh ] 
then
    chmod +x update.sh
else
    echo update file doesnt exists.
fi

echo -e " ${Cyan} Complete! ${NC}"
```
