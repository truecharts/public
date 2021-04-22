# How to: Create Certificates

At TrueCharts we support HTTPS deployments of every app using our Traefik Reverse Proxy. We support both self-signed, custom and lets-encrypt certificates, using the TrueNAS SCALE building certificate manager. Available under "Credentials"

### Self Signed certificates

Self signed certificates are relatively straight forward and handled by Traefik itself. You just select "self signed" when adding a reverse-proxy to your App and Traefik does the rest!

Please be aware that these certificates are not really secure, but are "good enough" for testing.

### Lets-Encrypt Certificates

With the current version of TrueNAS SCALE, it's possible to automatically generate certificates for your domain(s) using letsencrypt. However, this process is not very clear, hence we added a short how-to guide on getting up-and-running with TrueNAS SCALE and Letsencrypt.
After you managed to complete this how-to, you should be able to select "iX Certificate" as certificate option and your personal certificate in the other drop-down box!

##### Requirements

To use iX Certificates with letsencrypt there are a few requirements:
- Preferably use a DNS server that doesn't have any caching (no local DNS server) for your TrueNAS system.
- Have an email address entered for your TrueNAS SCALE `root` user. (this email will also be used for letsencrypt reminder!)
- Own a domain name
- Use either Cloudflare or AWS Route53 for your domain. (In case you wonder: Using Cloudflare as DNS provider is free)
- Have an active internet connection so TrueNAS SCALE can contact Cloudflare or AWS to verify your domain ownership

##### How-To

- Click `Credentials` in the Left side menu and go the `Certificates` page.


![Certificates](https://truecharts.org/_static/img/LE/LE2.png){ align=left }



- Notice `ACME DNS-Authenticators`, select `Add` besides `ACME DNS-Authenticators` to open the menu for adding your DNS provider for domain verification.


- Enter the required information and click `save`.
For Cloudflare you need either a global API-Key or a limited-scope API token. Please refer to cloudflare and/or AWS on how to get the required credentials.


![Certificates](https://truecharts.org/_static/img/LE/LE1.png){ align=left }


- Notice `Certificate Signing Requests`, select `Add` besides `Certificate Signing Requests` to open the menu for adding the domain information you want a certificate for.

![Certificates](https://truecharts.org/_static/img/LE/LE3.png){ align=left }


- Enter all information required in the wizard and save it.
If you are not sure, the defaults are alsmost always "alright", because most of what you enter here is completely ignored by Letsencrypt.
`Common Name` in this case means `Primary domain name`, whereas `Subject Alternate Names` means `Extra domain names`.


![Certificates](https://truecharts.org/_static/img/LE/LE5.PNG){ align=left }


- Notice your new `Certificate Signing Request` showing up in the box below `Certificate Signing Requests`. Also notice the small `wrench` icon to the right of your `Certificate Signing Request`


- Click the small `wrench` icon, this will open the `Create ACME Certificate` menu. In this menu we can actually request either a real (Production) certificate or a testing (staging) certificate from Letsencrypt.
For clearity, it's advicable to use the same Authenticator for all domain names. However: It's okey to generate both a testing and a staging certificate for the same domain.

- After saving and awaiting the generation proces, you should end up with another `Certificate Signing Request` and a new `Certificate` under `Certificates`, this new `Certificate Signing Request` is used to renew your `Certificate` in the future and should not be deleted!

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

##### New certificates not showing without refresh

Currently recently added certificates will not show in the App UI, without hitting the button to refresh the App list.
