# Installation Notes

If you want to use `Tailscale` in **non**-user mode, you have to run this as `root` user.
You can do this by editing the following

Under `Tailscale Configuration`

- Uncheck `Userspace`

Under `Security and Permissions`

- Check `Show Advanced Security Settings`
  - Uncheck `ReadOnly Root Filesystem`
  - Uncheck `runAsNonRoot`

Under `Pod Security Context`

- runAsUser: `0`
- runAsGroup: `0`
