# How to: Create Certificates

At TrueCharts we support HTTPS deployments of every app using our Traefik Reverse Proxy. We support both self-signed, custom and lets-encrypt certificates, using the TrueNAS SCALE building certificate manager. Available under "Credentials"

### Self Signed certificates

Self signed certificates are relatively straight forward and handled by Traefik itself. You just select "self signed" when adding a reverse-proxy to your App and Traefik does the rest!

Please be aware that these certificates are not really secure, but are "good enough" for testing.

### Lets-Encrypt Certificates

With the current version of TrueNAS SCALE, it's possible to automatically generate certificates for your domain(s) using letsencrypt. However, this process is not very clear, hence we added a short how-to guide as well.
After you managed to complete this, you should be able to select "iX Certificate" as certificate option and your personal certificate in the other drop-down box!

### Import existing certificates

TrueNAS SCALE also allows you to manually import certificates, this is rather straight forward:
Copy-Paste the keys into their respective boxes and hit `save`


### Notes

There are a few known bugs, issues and/or oddities currently in regards to Certificates

##### Error during certificate creation

ACME (the system doing letsencrypt) is not super stable on TrueNAS SCALE currently. This is a SCALE issue and not (directly) related to TrueCharts.
We suggest the following steps to limit the chance of errors during certificate creation:

- Use the DNS-Authenticators DNS server as TrueNAS SCALE DNS server under "Networking". For example, for cloudflare this would be `1.1.1.1`

- Use global Cloudflare API keys, not zoned Tokens

- Reboot after ACME errors

We sincerely hope iX Systems solves the ACME instabilities with due priority.

##### Traefik not accepting/using certificates

Sometimes you might notice Traefik ignores your certificate. This is most likely due to the domain on your certificate, being different from the domain you entered into the reverse proxy host box.
Traefik requires your certificate to match the domain used for Ingress. This is an upstream design decision and something we can easily and safely disable.
