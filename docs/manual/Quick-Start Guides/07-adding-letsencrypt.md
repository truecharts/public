# 07 - Adding Lets-Encrypt Certificates

With TrueNAS SCALE, it's possible to automatically generate certificates for your domain(s) using letsencrypt. However, this process is not very self-explainatory.
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


<a href="https://truecharts.org/_static/img/LE/LE2.png"><img src="https://truecharts.org/_static/img/LE/LE2.png" width="100%"/></a>


- Notice `ACME DNS-Authenticators`, select `Add` besides `ACME DNS-Authenticators` to open the menu for adding your DNS provider for domain verification.


- Enter the required information and click `save`.
For Cloudflare you need either a global API-Key or a limited-scope API token. Please refer to cloudflare and/or AWS on how to get the required credentials.


<a href="https://truecharts.org/_static/img/LE/LE1.png"><img src="https://truecharts.org/_static/img/LE/LE1.png" width="100%" /></a>

- Notice `Certificate Signing Requests`, select `Add` besides `Certificate Signing Requests` to open the menu for adding the domain information you want a certificate for.


<a href="https://truecharts.org/_static/img/LE/LE3.png"><img src="https://truecharts.org/_static/img/LE/LE3.png" width="100%" /></a>

- Enter all information required in the wizard and save it.
If you are not sure, the defaults are alsmost always "alright", because most of what you enter here is completely ignored by Letsencrypt.
`Common Name` in this case means `Primary domain name`, whereas `Subject Alternate Names` means `Extra domain names`.


<a href="https://truecharts.org/_static/img/LE/LE5.PNG"><img src="https://truecharts.org/_static/img/LE/LE5.PNG" width="100%" /></a>


- Notice your new `Certificate Signing Request` showing up in the box below `Certificate Signing Requests`. Also notice the small `wrench` icon to the right of your `Certificate Signing Request`


- Click the small `wrench` icon, this will open the `Create ACME Certificate` menu. In this menu we can actually request either a real (Production) certificate or a testing (staging) certificate from Letsencrypt.
For clearity, it's advicable to use the same Authenticator for all domain names. However: It's okey to generate both a testing and a staging certificate for the same domain.

- After saving and awaiting the generation proces, you should end up with another `Certificate Signing Request` and a new `Certificate` under `Certificates`, this new `Certificate Signing Request` is used to renew your `Certificate` in the future and should not be deleted!


#### Video Guide

![type:video](https://www.youtube.com/embed/KC7wGqusSxE)
