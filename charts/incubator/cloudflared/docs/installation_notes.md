# Installation Notes

- Go to [cloudflare team dash](https://dash.teams.cloudflare.com)
and create a tunnel or migrate a current tunnel(this action is not reversible)

- Copy the token from tunnel's overview **Install and run a connector** section,

  this is what your token may look like.

  ```text
  eyJhIjoiNDJhYmYwMTQzNGMyMeUzNDMzMTE1Y2M0YmFhZGY0YTciLCJ0IjoiNzBiNza5zTItMWViMS00MjdjaWFiZjEtZWMwdzIwNmQwZmI3IiwicyI6IlltRmxPV1ExTldZdE16a3lOUzAwsW1KbUxUZzJPVGN0Wm1VelptVmpaak00T1dZeiJ5
  ```

- Set `token` with **your** tunnel's token

- Now you can manage the tunnel via cloudflare dash by setting a private network or create ingress rules for your services and domain.
