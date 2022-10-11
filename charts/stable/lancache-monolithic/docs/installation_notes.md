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

Always be cautious when running unkown scripts and read them over before executing.

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

- Checkout the [install_steam.sh](https://gist.github.com/Xstar97/769878e95e4c505d7339fc840b88c82e) here.

### BattleNetPrefill

- This is a small modified update script from SteamPrefill to install BattleNetPrefill.
- Add this script to the `/data` dir and name it for ex: `install_battlenet.sh`.
- run this command on the script `chmod +x install_battlenet.sh` to be able to execute it from the shell.
- This script will create a new dir called `BattleNet` and grab the latest zip from `tpill90` repo for BattlenetPrefill and auto chmod +x for you.
- Then `cd BattleNet` if still in `/data` and execute `./BattleNetPrefill -h`.

- BattleNetPrefill doesnt require an account. But the command to prefill are a bit different.
- In order to prefill a specific game. you need to run this command first `./BattleNetPrefill list-products` to get the product ID.
- Then you can run `./BattleNetPrefill prefill -p PRODUCT_ID`.

- Checkout the [install_battlenet.sh](https://gist.github.com/Xstar97/ebb42ccbd9b00a1407e363dbd917309b) here.
