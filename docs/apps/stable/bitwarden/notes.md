# Installation Notes

* NodePort is not available as an option, as Bitwarden_rs requires HTTPS and a proxy to split webtraffic from https. ( https://github.com/dani-garcia/bitwarden_rs/wiki/Enabling-HTTPS )
* NodePort not being an option, means Ingress is a requirement too.
