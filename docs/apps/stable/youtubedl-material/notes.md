# Installation Notes

## By default Youtube-dl uses the following directories, which are NOT persistence. 
## Everything in `/data`, `/app` and `/config` gets WIPED on boot.


* Videos with 'Audio only' checked, by default downloads to `/data/audio/`
* Video files, by default downlods to `/data/video`
* Subscriptions ("watched" channels or playlists) by default downloads to `/data/subscriptions/`
* If Multi-user is enabled all downloads goes, by default to `/data/users/` ignoring the previous mentioned directories

To easily access the above directories, add them as custom storage. eg `/audio`, `/video`, `subscriptions`, `/users`  
If you plan to use multi-user, you only need 1 directory, `/users`.
DO NOT add custom storage in `/data`, `/app` and `/config` it will be wiped on the next boot.
Then you have to manually map them on the WebUI also. (Top right corner > 3-Dots > Settings > Main and Downloader tabs)