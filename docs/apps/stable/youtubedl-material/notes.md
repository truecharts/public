# Installation Notes



## By default Youtube-dl uses the following directories.
* Audio only files by default downloads to `/app/audio/`
* Video files by default downlods to `/app/video`
* Subscriptions by default downloads to `/app/subscriptions/`
* Multi-user support uses by default `/app/users/`

## When adding custom storages with different paths than the above mentioned, you have to manually map them on the WebUI also.
### If you don't add any custom storage, all downloads will be saved in the persistence storage, which won't be easily accessible via SMB share.