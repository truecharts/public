---
slug: "news/train-renames"
title: "Refreshed Train Names, Team Changes and DragonFish Support"
authors: [ornias]
date: 2024-03-16
tags:
  - "2024"
---

We're back with some thrilling announcements that promise to enhance your experience with our platform. From revamped train names to key team appointments and even experimental support for TrueNAS SCALE 24.04 DragonFish, there's a lot to unpack. Let's dive right in!

## Train Name Refresh: Introducing Premium and System Trains

First off, we're thrilled to introduce our revamped train names: Premium Train and System Train. Say goodbye to the old names; these new labels better align with the quality and breadth of resources you'll find within.
You'll find both an automated script _and_ a one-by-one version to deal with this name change for you, for both SCALE and Helm platforms, at the [bottom](#note-automated-migration-script-for-train-name-changes) of this article.

### Enterprise out, Premium in

This change reflects the fact that this train no longer specifically targets enterprise customers, but in general stands for higher-quality charts.

### Hello, Operator? No, this is System

This name change reflects this train no longer just containing operators, but now also includes additional important system charts.

## Meet Our New Team Appointments

1. **@bitpushr Assumes Role of Docs Maintainer:**
   Join us in welcoming @bitpushr as our new Docs Maintainer, succeeding @JagrBombs (Steven). With their expertise and dedication, we're confident our documentation will remain top-notch.

2. **@kofeh Takes Charge as Support Coordinator:**
   Say hello to @kofeh, our new Support Coordinator, succeeding @Xstar97TheNoob. With his stellar communication skills, he's ready to ensure you receive the assistance you need.

3. **@Xstar97TheNoob Transitions to Stable Train Maintainer:**
   We're proud to announce that @Xstar97TheNoob is now our Stable Train Maintainer, ensuring the stability and reliability of our platform.

## Experimental Support for TrueNAS SCALE 24.04 DragonFish

In a bold move, we've added initial prototype support for TrueNAS SCALE 24.04 DragonFish. However, it's crucial to note that this support is still highly experimental. As such, we do not offer staff support or guarantee data integrity for the BETA or TC versions of TrueNAS SCALE 24.04 DragonFish.
You can read more on the steps required for running TrueNAS SCALE 24.04 Dragonfish [here](/.

## Our Successful Bounty Program

We're thrilled to share that our new bounty program has been incredibly successful! This initiative allows contributors to earn rewards for their valuable contributions to our project. If you'd like to learn more or get involved, check out our bounty program on Open Collective: [TrueCharts Bounties](https://opencollective.com/truecharts-bounties).

**A Note on Donations**

While our bounty program has seen fantastic results, it's important to note that bounties do not replace donations. Our project relies on the continued support of our loyal donors to thrive. If you'd like to contribute to our cause, consider making a donation via our Open Collective page: [Donate to TrueCharts](https://opencollective.com/truecharts).

## Conclusion

With these updates and additions, we're committed to providing you with an unparalleled experience on our platform. As always, your feedback is invaluable to us. Reach out with any questions or suggestions, and stay tuned for more exciting developments!

Thank you for being part of the TrueCharts community.

## Note: Automated Migration Script for train name changes

To ensure a seamless transition to the new train names, we've developed a script that automates the process across all relevant namespaces. Here's the code!
Please be aware we do not give guarantees and this script may need adapting to your environment and/or additional permissions.

### Helm Platform - Automated Migration Script

_save as nameupdate.sh and run `chmod +x nameupdate.sh` before running it_

```bash
#!/bin/bash

# Loop through all namespaces prefixed by "ix-"
for ns in $(kubectl get namespaces -o jsonpath='{.items[*].metadata.name}' | grep '^ix-'); do
    # Check if the namespace has "catalog_train" label set to "enterprise" or "operators"
    catalog_train_label=$(kubectl get namespace "$ns" -o jsonpath='{.metadata.labels.catalog_train}')
    if [[ "$catalog_train_label" == "enterprise" ]]; then
        # Patch the namespace to change the "catalog_train" label to "premium"
        kubectl patch namespace "$ns" -p '{"metadata":{"labels":{"catalog_train":"premium"}}}'
        echo "Namespace $ns updated from enterprise to premium."
    elif [[ "$catalog_train_label" == "operators" ]]; then
        # Patch the namespace to change the "catalog_train" label to "system"
        kubectl patch namespace "$ns" -p '{"metadata":{"labels":{"catalog_train":"system"}}}'
        echo "Namespace $ns updated from operators to system."
    fi
done

```

### SCALE Platform - Automated Bash Shell Migration Script

_simply copy-paste this into the shell of your TrueNAS SCALE GUI_

```bash

curl -sSL https://raw.githubusercontent.com/xstar97/scale-scripts/main/scripts/patchTCTrains.sh | bash --

```

### SCALE Platform - Automated Migration Script

_save as nameupdate.sh and run `chmod +x nameupdate.sh` before running it_

```bash
#!/bin/bash

# Loop through all namespaces prefixed by "ix-"
for ns in $(k3s kubectl get ns --no-headers | grep "^ix-" | awk '{print $1}' ORS=' '); do
    # Check if the namespace has "catalog_train" label set to "enterprise" or "operators"
    catalog_train_label=$(k3s kubectl get namespace "$ns" -o jsonpath='{.metadata.labels.catalog_train}')
    if [[ "$catalog_train_label" == "enterprise" ]]; then
        # Patch the namespace to change the "catalog_train" label to "premium"
        k3s kubectl patch namespace "$ns" -p '{"metadata":{"labels":{"catalog_train":"premium"}}}'
        echo "Namespace $ns updated from enterprise to premium."
    elif [[ "$catalog_train_label" == "operators" ]]; then
        # Patch the namespace to change the "catalog_train" label to "system"
        k3s kubectl patch namespace "$ns" -p '{"metadata":{"labels":{"catalog_train":"system"}}}'
        echo "Namespace $ns updated from operators to system."
    fi
done

```

### Manual Migration Script

_Use this script to manually migrate your existing SCALE apps to the new trains. Replace `blocky` with the app name in question and `premium` with the new train-name_.

```bash
k3s kubectl patch ns ix-blocky -p '{"metadata":{"labels":{"catalog_train":"premium"}}}'
```
