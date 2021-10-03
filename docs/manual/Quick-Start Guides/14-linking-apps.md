# 14 - Linking Apps Internally

We often need to connect individual apps together, for example: Sonarr and SABnzbd. This means we first need to know how to reach those Apps.

##### Linking Apps Internally

The backend for TrueNAS SCALE Apps is Kubernetes. Linking apps together in Kubernetes is done slightly differently than in other systems, as you can't point directly to other containers using their IP address.

Instead we need to use their internal(!) domain name. Please beware: this name is only available between Apps and can not be reached from the host/node or your own PC.

The format for internal domain name for the main service is explained bellow.
Please replace `$NAME` with the name you gave your App when installing and `$APP` with the name the app has on the catalog where is needed.

**If your app has the _same_ name as in the catalog, the format is as follows.**

- `$NAME.ix-$NAME.svc.cluster.local`

**If your app has _different_ name than in the catalog, the format is as follows**

- `$NAME-$APP.ix-$NAME.svc.cluster.local`


If you need to reach a different service (which is not often the case!), you need a slightly different format, where `$SVCNAME` is the name of the service you want to reach:

**If your app has the _same_ name as in the catalog, the format is as follows.**

- `$NAME-$SVCNAME.ix-$NAME.svc.cluster.local`

**If your app has _different_ name than in the catalog, the format is as follows**

- `$NAME-$APPNAME-$SVCNAME.ix-$NAME.svc.cluster.local`

##### Internal Domain Name generator

<link href="https://truecharts.org/_static/form.css" type="text/css" rel="stylesheet" />
<FORM id="frameform"><BR>
<div class="form">
  <div class="subtitle">Generate Internal DNS Name:</div>
  <div class="input-container ic1">
    <input required id="name" class="input" type="text" placeholder=" " />
    <div class="cut cut-short-name"></div>
    <label for="name" class="placeholder">Name</label>
  </div>
  <div class="input-container ic2">
    <input required id="app" class="input" type="text" placeholder=" " />
    <div class="cut cut-short-app"></div>
    <label for="app" class="placeholder">App</label>
  </div>
  <div class="input-container ic2">
    <input id="service" class="input" type="text" placeholder=" " />
    <div class="cut"></div>
    <label for="service" class="placeholder">Service (Optional)</>
  </div>
  <INPUT TYPE="submit" class="submit" NAME="button" Value="Generate">
</div>
</FORM>

<SCRIPT LANGUAGE="JavaScript">
const form = document.getElementById('frameform');
const name = document.getElementById('name');
const app = document.getElementById('app');
const service = document.getElementById('service');

form.onsubmit = submit;

function submit(event) {


    var svcname = ""
    if (name.value == app.value) {
      svcname = name.value ;
    } else {
      svcname = name.value + "-" + app.value ;
    }
    if (service.value) {
      svcname = svcname + "-" + service.value ;
    }
    let svcdns = svcname + "." + "ix-" + name.value + ".svc.cluster.local" ;
    alert ("Service DNS Name: " + svcdns);
     console.log(svcdns)
    return false;
}
</SCRIPT>

##### Example

To reach an app named "sabnzbd" (same name as the catalog app name) within Sonarr, we can use the following internal domain name:

- `sabnzbd.ix-sabnzbd.svc.cluster.local` or
- `sabnzbd.ix-sabnzbd`

<a href="https://truecharts.org/_static/img/linking/linking-example-sonarrsabnzbd.png"><img src="https://truecharts.org/_static/img/linking/linking-example-sonarrsabnzbd.png" width="100%"/></a>

#### Video Guide

![type:video](https://www.youtube.com/embed/kLzFGCOOGXQ)

##### Additional Documentation

For more help troubleshooting DNS resolution in Kubernetes, review the official documentation: https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/
