# Overview

Spinnaker is an open source, multi-cloud continuous delivery platform for
releasing software changes with high velocity and confidence.

If you would like to learn more about Spinnaker, please visit the
[Spinnaker website](https://spinnaker.io/).

## About Google Click to Deploy

Popular open stacks on Kubernetes packaged by Google.

## Architecture

### TODO: Create architecture diagram

![Architecture diagram](resources/spinnaker-k8s-app-architecture.png)

This solution install a single instance of Spinnaker into a Kubernetes cluster.
Our goal is to provide an easy initial installation experience, as well as an
environment and workflow for ongoing management of Spinnaker by an individual
or a team.

Spinnaker is composed of a number of individual
[micro services](https://www.spinnaker.io/reference/architecture/), and each
will be deployed in their own Pods, managed by Deployment objects, behind
Service objects.

[Halyard](https://www.spinnaker.io/reference/halyard/) is Spinnaker's
configuration service and consists of a CLI and a daemon. The CLI will be
installed in your Cloud Shell and the daemon will be installed in a Pod managed
by a StatefulSet object.

[Spin](https://www.spinnaker.io/guides/spin/app/) is Spinnaker's CLI. It will
be installed in your Cloud Shell.

The Spinnaker solution will not be exposed to external traffic by default.
A good initial step is accessing Spinnaker via port forwarding, and a script is
included for automatically establishing port forwarding. In addition, the
solution includes guidance and automation for exposing Spinnaker via a secure
domain behind the [Identity-Aware Proxy](https://cloud.google.com/iap/).

# Installation

## Quick install with Google Cloud Shell

You must use [Google Cloud Shell](https://cloud.google.com/shell/) to perform the installation.

[![Provision Spinnaker](https://gstatic.com/cloudssh/images/open-btn.png)](https://console.cloud.google.com/cloudshell/editor?cloudshell_git_repo=https://github.com/duftler/scratch.git&cloudshell_working_dir=scripts/install&cloudshell_tutorial=provision-spinnaker.md)

### Prerequisites

#### Set up command line tools

Cloud Shell has all the required tools pre-installed.

#### Create a Google Kubernetes Engine cluster

The Spinnaker installation process will create a new GKE cluster by default. If
you would prefer to use an existing cluster, you must ensure that it has:
* IP aliases enabled (since we are using a
[hosted Redis](https://cloud.google.com/memorystore/) instance)
* `Full Cloud Platform` scope for its nodes (if using the default service account)

#### Install the Solution

When you click on the "Open in Google Cloud Shell" button above, a tutorial
pane will open with several copy/paste commands. As part of this process, a
`properties` file will be generated. You can modify the values in the generated
`properties` file to fine-tune the installation _prior_ to launching the actual
`setup` script.

When the initial installation process completes, you can use the remaining
copy/paste commands to locate your Spinnaker deployment in the GKE Applications
view, access Spinnaker via port-forwarding, expose Spinnaker securely, share
Spinnaker with your teammates, and so on.

#### Ongoing Management of Spinnaker

The ongoing management workflow will be as follows:

* Locate your Spinnaker installation by navigating to the newly-registered
Kubernetes Application via the
[Applications](https://console.developers.google.com/kubernetes/application?project=_)
view.
* Click the link from the Spinnaker Application to open Cloud Shell and clone
this repo
* Ensure you are connected to the correct GKE cluster (that is, the one
containing the Spinnaker deployment you intend to manage)
* Pull all the config from the Spinnaker deployment into your Cloud Shell
environment
* Update the Cloud Shell tutorial pane to reflect the newly-pulled config
* Make all of your changes using `hal` in Cloud Shell (often by simply
copying & pasting commands); `hal` will apply its changes and perform its
validation against a Halyard daemon running in Cloud Shell
* Push your changes back to the Spinnaker deployment (a full config backup is
implicitly pushed to a bucket as well)
* Apply your changes to the Spinnaker deployment

There are scripts provided for each of these steps, and copy/paste commands and
instructions are rendered in the Cloud Shell tutorial pane.

This approach allows for an Admin to manage multiple Spinnaker deployments, as
the source of truth for the deployment's configuration is always the deployment
itself. It also allows for easily sharing management of Spinnaker among
multiple Admins.
