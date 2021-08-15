# 14 - Linking Apps Internally

We often need to connect individual apps together, for example: Sonarr and SABnzbd. This means we first need to know how to reach those Apps.

##### Linking Apps Internally

The backend for TrueNAS SCALE Apps is Kubernetes. Linking apps together in Kubernetes is done slightly differently than in other systems, as you can't point directly to other containers using their IP address.

Instead we need to use their internal(!) domain name. Please beware: this name is only available between Apps and can not be reached from the host/node or your own PC.

The format for internal domain name for the main service is as follows, please replace `$APPNAME` with the name you gave your App when installing.

- `$APPNAME.ix-$APPNAME.svc.cluster.local`

Kubernetes can usually identify the app when omitting `svc.cluster.local` as well:
- `$APPNAME.ix-$APPNAME`

If you need to reach a different service (which is not often the case!), you need a slightly different format, where `$SVCNAME` is the name of the service you want to reach:

- `$SVCNAME.ix-$APPNAME.svc.cluster.local` or
- `$SVCNAME.ix-$APPNAME`

##### Example

To reach an app named "sabnzbd" within Sonarr, we can use the following internal domain name:

- `sabnzbd.ix-sabnzbd`

<a href="https://truecharts.org/_static/img/linking/linking-example-sonarrsabnzbd.png"><img src="https://truecharts.org/_static/img/linking/linking-example-sonarrsabnzbd.png" width="100%"/></a>


##### Internal Domain Name generator


<SCRIPT LANGUAGE="JavaScript">
function process (form) {
    var svcdns = generatesvc(form.name.value, form.app.value, form.service.value);
    alert ("Service DNS Name: " + svcdns);
     console.log(svcdns)
}



function generatesvc(name, app, service) {
    let svcdns = name + app + service;
    return svcdns;
};

</SCRIPT>

<FORM NAME="frameform" ACTION="" METHOD="GET">Generate Internal DNS Name:<BR>
<input type="text" NAME="name">
<input type="text" NAME="app">
<input type="text" NAME="service">
<P>

<INPUT TYPE="button" NAME="button" Value="Click" onClick="process(this.form)">
</FORM>

#### Video Guide

![type:video](https://www.youtube.com/embed/TKh7NXjk91w)

##### Additional Documentation

For more help troubleshooting DNS resolution in Kubernetes, review the official documentation: https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/
