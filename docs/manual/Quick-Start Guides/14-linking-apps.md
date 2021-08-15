# 14 - Linking Apps Internally

<SCRIPT LANGUAGE="JavaScript">
function testResults (form) {
    var svcdns = generatesvc(form.name.value, form.app.value, form.service.value);
    alert ("Service DNS Name: " + svcdns);
     console.log(svcdns)
}



function buildHexStringCommand(name, app, service) {
    let svcdns = name + app + service;
    return svcdns;
};

</SCRIPT>

<BODY>
<FORM NAME="frameform" ACTION="" METHOD="GET">Generate Internal DNS Name:<BR>
<input type="text" NAME="name">
<input type="text" NAME="app">
<input type="text" NAME="service">
<P>

<INPUT TYPE="button" NAME="button" Value="Click" onClick="testResults(this.form)">

#### Video Guide

![type:video](https://www.youtube.com/embed/TKh7NXjk91w)
