# 09 - Exposing Apps using Ingress and Traefik

To use Traefik as ingress, all you have to do is enable "ingress" in the App of your choice and fill out a little form.
We currently require Traefik to be installed before you enable ingress on your App.


##### Requirements

- Make sure your storage-pool is created and working
- Make sure you selected your storage-pool when you first opened the "Apps" interface, if not please refer to quick-start guide `01 - First time Apps setup`
- Make sure you have a working internet connection and can reach github and truecharts.org from the host system.
- Make sure you already added the TrueCharts catalog from guide 02
- Make sure your App is installed and, preferably, working
- Make sure you added your certificates in guide 09
- Make sure you've setup traefik in guide 10


#### Video Guide

![type:video](https://www.youtube.com/embed//MlyRvF3rOhE)


### Notes

There are a few highlights to take into account when adding a ingress to an App:

- Adding hosts is required
By default the hosts list is empty, this is due to upstream design choices and is a issue that is yet to be solved upstream.
However: adding hosts (preferably just one) is required for ANY app to function with a ingress enabled. Apps might not install and throw errors if you do not add any hosts.

- Traefik not accepting/using certificates
Sometimes you might notice Traefik ignores your certificate. This is most likely due to the domain on your certificate, being different from the domain you entered into the reverse proxy host box.
Traefik requires your certificate to match the domain used for Ingress. This is an upstream design decision and something we can easily and safely disable.
