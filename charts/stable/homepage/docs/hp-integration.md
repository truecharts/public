# Homepage Truecharts integration guide
TrueCharts has adopted HomePage for it defacto dashboard application due to its support of kubernetes  

This Guide will cover how to use the Truecharts/Homepage integration included in the chart and the editing of the yaml files in homepage using the code-server addon. this guide will not cover every aspect of options available to homepage. Please see the Homepage links below for more information  

⚠️ Ingress is required for the truecharts integrations to function. You can use the kubernetes integrations if you manually define all settings⚠️

## Homepage Links
Github: https://github.com/gethomepage/homepage  
WebSite https://gethomepage.dev/  

### Getting Started
   Install Truecharts Homepage and enable code-server addon. for this guide i'll just be using ip:port
  ![code-server section](img/image.png)

  put in the IP:port in to your browser. the IP will depend on your setup but usually the scale IP  

  once in code server under app/config you will see the following files these will allow you to manipulate many aspects. but first we will turn on homepage kube support by editing kubernetes.yaml  

  For Scale users you will enter ```mode:default``` Native Helm Users may need to user ```mode:cluster```  which will use a service account  
  
![kubeyml](img/kubeyml.png)

To confirm that the home page install is recognizing your scale/kubernetes setup  you can edit widgets.yaml and enter the following  

```
- kubernetes:
    cluster:
      # Shows cluster-wide statistics
      show: true
      # Shows the aggregate CPU stats
      cpu: true
      # Shows the aggregate memory stats
      memory: true
      # Shows a custom label
      showLabel: true
      label: "cluster"
    nodes:
      # Shows node-specific statistics
      show: true
      # Shows the CPU for each node
      cpu: true
      # Shows the memory for each node
      memory: true
      # Shows the label, which is always the node name
      showLabel: true
```
which will result in the following being added  
![hp kube enable check](img/hpenablechck.png)  

We can now enable our first integration!

### Enabling Integration in charts
Edit and existing chart with ingress and go to the ingress section and enable the homepage integration checkbox  

Name can be left blank or use the name of your choice.  
Description can be left blank or you can use the description of your choice  
:exclamation: Group is important it will allow you to group the Diffrent apps togeather so for example all your media apps you may want in a group called "Media" for this example we are using sonarr/radarr with groups Test and Test2

![Integration](img/int1basic.png)

which results in the following in Homepage, the API error is due to no API keys being entered yet, we will take care of that now. edit the app again and use the Widgets Settings as so
