# Contributing to TrueNAS Official Catalog

:+1::tada: First off, thanks for taking the time to contribute! :tada::+1:

The following is a set of guidelines for contributing to TrueNAS Official Catalog, which are hosted in the [TrueNAS Organization](https://github.com/truenas) on GitHub.

#### Table Of Contents

[Code of Conduct](#code-of-conduct)

[I don't want to read this whole thing, I just have a question!!!](#i-dont-want-to-read-this-whole-thing-i-just-have-a-question)

[What should I know before I get started?](#what-should-i-know-before-i-get-started)
  * [Helm](#helm)
  * [TrueNAS Compliant Catalog](#truenas-compliant-catalog)

[How Can I Contribute?](#how-can-i-contribute)
  * [Reporting Bugs](#reporting-bugs)
  * [Suggesting Enhancements](#suggesting-enhancements-or-request-for-a-new-official-applications-to-be-included)
  * [Contributing a New Official Application](#contributing-a-new-official-application)


## Code of Conduct

This project and everyone participating in it is governed by the [TrueNAS Charts Code of Conduct](CODE_OF_CONDUCT.md). By participating, you are expected to uphold this code. Please report unacceptable behavior to [dev@ixsystems.com](mailto:dev@ixsystems.com).

## I don't want to read this whole thing I just have a question!!!

> **Note:** [Please don't file an issue to ask a question.]

We have an official forum where the community chimes in with helpful advice if you have questions.

* [TrueNAS Forum](https://www.truenas.com/community/)

## What should I know before I get started?

### Helm

Helm is an open source project which is basically the apt equivalent of kubernetes. TrueNAS Applications are actually
helm charts.

Here's a list of some useful helm resources to get started with:

* [Getting Started with Helm](https://helm.sh/docs/chart_template_guide/getting_started/) - A basic guide explaining
how to make helm charts
* [Basic understanding of helm workflow](https://medium.com/bb-tutorials-and-thoughts/how-to-get-started-with-helm-b3babb30611f) -
A guide to understanding helm architecture and how helm charts operate.

There are many more, but this list should be a good starting point.

### TrueNAS compliant catalog

An understanding of how TrueNAS catalog works. The structure and format is documented in this [document](README.md).

## How Can I Contribute?

### Reporting Bugs

Before creating bug reports, please check our [bug tracker](https://jira.ixsystems.com/issues/?jql=) as you might find out that you don't need to create one. When you are creating a bug report, please [include as many details as possible](#how-do-i-submit-a-good-bug-report).

> **Note:** If you find a **Closed** issue that seems like it is the same thing that you're experiencing, open a new issue and include a link to the original issue in the body of your new one.

#### How Do I Submit A (Good) Bug Report?

Bugs are tracked as [JIRA issues](https://jira.ixsystems.com/). After you've determined that a bug report needs to
be created, please follow the following guidelines when creating the issue.

Explain the problem and include additional details to help maintainers reproduce the problem:

* **Use a clear and descriptive title** for the issue to identify the problem.
* **Describe the exact steps which reproduce the problem** in as many details as possible. For example, start by
explaining how the problem occurs so that responsible developers working on it can reliably reproduce the issue to have
it fixed in a timely fashion
* **Describe the behavior you observed after following the steps** and point out what exactly is the problem with that behavior.
* **Explain which behavior you expected to see instead and why.**.

Provide more context by answering these questions:

* **Did the problem start happening recently** (e.g. after updating to a new version of an official application) or was this always a problem?
* If the problem started happening recently, **can you reproduce the problem in an older version of the application?** What's the most recent version in which the problem doesn't happen?
* **Can you reliably reproduce the issue?** If not, provide details about how often the problem happens and under which conditions it normally happens.


### Suggesting Enhancements or request for a new Official Applications to be Included

This section guides you through submitting an enhancement suggestion for an official application, including completely new features and minor improvements to existing functionality. Following these guidelines helps maintainers and the community understand your suggestion :pencil: and find related suggestions :mag_right:.

Before creating enhancement suggestions, please check [this list](https://jira.ixsystems.com/browse/NAS-110314?jql=project%20%3D%20NAS%20AND%20issuetype%20%3D%20Suggestion) as you might find out that you don't need to create one.


### Contributing a New Official Application

The workflow for adding a new official application is as follows:

1. Create a github issue [here](https://github.com/truenas/charts) which should outline the following points:
   1. Which app is being proposed to be added to the catalog ?
   2. How do you think it is useful for users ?
   3. Who will be maintaining the new application ?
2. The TrueNAS team would get approval on the issue and based on that rest of the steps would be followed
3. After (2) approval, create a PR [here](https://github.com/truenas/charts/pulls) adding the application to
`community` train making sure that it complies with the [Official Catalog Application Standards](#Application-standards)
4. The application would be added to the community train after passing (3).

Based on usage and utility, every few months the applications would be re-visited by the TrueNAS team and some
might be moved over to the main train by the team.

#### Application Standards

The application should conform to the following standards to be accepted in the community train:

1. Depending on usage, the app should have persistent storage either by using ix volumes or host path volumes.
2. It should have a helm test to actually test to ensure that the application deploys and works nicely ( learn more
 about `helm test` [here](https://helm.sh/docs/topics/chart_tests/) or you can see an example 
[here](https://github.com/truenas/charts/blob/master/charts/nextcloud/1.5.0/templates/tests/deployment-check.yaml))
3. It should have an upgrade strategy defined so that the application can be automatically updated whenever a docker
image it consumes has a newer tag available. For details please see this tool which is used to automatically
allow automated upgrades [TrueNAS Catalog Update](https://github.com/truenas/catalog_update).

Before the application can be accepted, it must pass our CI tests which comprise the following checks:
1. Validation of the catalog itself i.e [TrueNAS Catalog Validation](https://github.com/truenas/catalog_validation)
2. Application in question being deployed in the CI and ensuring it's `helm test` succeeds
