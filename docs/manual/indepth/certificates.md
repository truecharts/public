# How to: Create Certificates

At TrueCharts we support HTTPS deployments of every app using our Traefik Reverse Proxy. We support both self-signed, custom and lets-encrypt certificates, using the TrueNAS SCALE building certificate manager. Available under "Credentials"

### Self Signed certificates

Self signed certificates are relatively straight forward and handled by Traefik itself. You just select the default TrueNAS certificate when adding a ingress to your App and Traefik does the rest!
Please be aware that these certificates are not really secure, but are "good enough" for testing.

### Lets-Encrypt Certificates

With the current version of TrueNAS SCALE, it's possible to automatically generate certificates for your domain(s) using letsencrypt. However, this process is not very clear, hence we added a short how-to guide as well.
After you managed to complete this, you should be able to select "iX Certificate" as certificate option and your personal certificate in the other drop-down box!

### Import existing certificates

TrueNAS SCALE also allows you to manually import certificates, this is rather straight forward:
Copy-Paste the keys into their respective boxes and hit `save`
