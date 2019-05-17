# Overview

Spinnaker is an open source, multi-cloud continuous delivery platform for
releasing software changes with high velocity and confidence.

If you would like to learn more about Spinnaker, please visit the
[Spinnaker website](https://spinnaker.io/).

## About Google Click to Deploy

Popular open stacks on Kubernetes packaged by Google.

## About Spinnaker for Google Cloud Platform

This solution installs a single instance of Spinnaker into a GKE cluster in a
production-ready configuration. The installation follows recommended practices
for running Spinnaker on Google Cloud Platform, and is integrated with related
Google Cloud services, such as [Cloud Build](https://cloud.google.com/cloud-build/).

This solution also provides a simplified configuration experience, as well as a
management environment and workflow for ongoing administration of Spinnaker.

## Architecture

### TODO: Create architecture diagram

![Architecture diagram](resources/spinnaker-k8s-app-architecture.png)

Spinnaker is composed of a number of individual
[microservices](https://www.spinnaker.io/reference/architecture/). These
will be deployed in their own Kuberetes Pods, managed by Deployment objects,
behind Service objects.

[Halyard](https://www.spinnaker.io/reference/halyard/) is Spinnaker's
configuration service and consists of a CLI and a daemon. The CLI will be
installed in the management environment (based on Cloud Shell) included in
this solution. The daemon will be installed in a Pod managed by a StatefulSet
object.

[Spin](https://www.spinnaker.io/guides/spin/app/) is Spinnaker's CLI. It is also
available in the management environment.

As a safe default, the Spinnaker instance is not exposed to external traffic, and
is accessed via port forwarding. Port forwarding can be set up with a single command
from the management environment. Alternatively, the management environment allos you
to expose Spinnaker via the [Identity-Aware Proxy](https://cloud.google.com/iap/), using
a secure domain.

# Installation

## Quick install via the management console

You must use the management environment, based on [Cloud Shell](https://cloud.google.com/shell/),
to perform the installation.

[![Provision Spinnaker](https://gstatic.com/cloudssh/images/open-btn.png)](https://console.cloud.google.com/cloudshell/editor?cloudshell_git_repo=https://github.com/GoogleCloudPlatform/click-to-deploy.git&cloudshell_working_dir=k8s/spinnaker/scripts/install&cloudshell_tutorial=provision-spinnaker.md)

### Prerequisites

#### Set up command line tools

The management environment has all the required tools pre-installed.

#### Create a Google Kubernetes Engine cluster

By default, the installation process will create a new GKE cluster for your Spinnaker
instance. To use an existing cluster, you must ensure that it has:

* IP aliases enabled (since we are using a
[Cloud Memorystore for Redis](https://cloud.google.com/memorystore/) instance)
* `Full Cloud Platform` scope for its nodes (if using the default service account)

#### Install Spinnaker for Google Cloud Platform

When you click on the "Open in Google Cloud Shell" button above, the management
environment will open and ask you to copy/paste and execute a number of commands.

As part of this process, a `properties` file will be generated. You can modify the
values in the generated `properties` file to fine-tune the desired configuration
_prior_ to launching the actual `setup` script.

When the initial installation process completes, additional commands will be shown
to allow you to:

* locate your Spinnaker deployment in the GKE Applications view
* access Spinnaker via port-forwarding
* expose Spinnaker securely using IAP
* allow others to administer and/or access Spnnakeir

and more.

#### Ongoing Management of Spinnaker

To manage your Spinnaker instance once installed:

* Locate your Spinnaker installation by navigating to the newly-registered
Application in the
[GKE Applications](https://console.developers.google.com/kubernetes/application?project=_)
view.
* Click the link from the Spinnaker Application to open the management
environment in Cloud Shell, and update it by cloning this repo
* Verify that you are managing the correct Spinnaker instance by ensuring that you
are connected to the GKE cluster containing the Spinnaker instance you intend to manage
* Update your configuration but pulling the config from the Spinnaker instance into your
management environment.
* Refresh the management environment interface to reflect your updated configuration
* Make all of your changes using `hal` in Cloud Shell, using the commands provided by the
management environment, or by entering commands directly. `hal` will validate and apply your
changes
* Push the updated configuration to your Spinnaker instance. The configuration is automatically
backed up to GCS as part of this process.
* Apply your changes to the Spinnaker instance

Scripts are provided for each of these steps, and copy/paste commands and instructions
are rendered in the management environment in the Cloud Shell tutorial pane.

This approach allows an administrator to manage multiple Spinnaker instances from the
same management environment. The source of truth for each instance is always the instance
itself, with a secure backup in [Google Cloud Storage](https://cloud.google.com/storage).
This makes it easy for multiple admins, each with their own management environment, to
adminster many Spinnaker instances.