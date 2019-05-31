# Install Spinnaker

## Select GCP project

Select the project in which you'll install Spinnaker, then click **Next**, below.

<walkthrough-project-billing-setup>
</walkthrough-project-billing-setup>

## Spinnaker Installation

Now let's provision Spinnaker within {{project-id}}.

Click the copy/paste button on the command below to copy that command to your shell,
then press **Enter** to run it from the Shell.

### Configure the environment.

```bash
PROJECT_ID={{project-id}} ~/click-to-deploy/k8s/spinnaker/scripts/install/setup_properties.sh
```

After that script finishes, you can click the link below to open the properties file for your Spinnaker
installation. This is optional.

<walkthrough-editor-open-file
    filePath="click-to-deploy/k8s/spinnaker/scripts/install/properties"
    text="Open properties file">
</walkthrough-editor-open-file>

**Proceed with caution**. If you edit this file, the installation might not work
as expected.

### Begin the installation

**This will take some time**

```bash
~/click-to-deploy/k8s/spinnaker/scripts/install/setup.sh
```

Watch the Cloud Shell command line to see when it completes, then click
**Next** to continue to the next step.

## Connect to Spinnaker

You'll now run commands to...
* connect to Spinnaker 
* open the Spinnaker UI (Deck) in a browser window

You have two choices:
* forward port 8080 to tunnel to Spinnaker from your Cloud Shell
* expose Deck securely via a public IP

### Forward the port to Deck, and connect

Don't use the `hal deploy connect` command. Instead, use the following command
only.

```bash
~/click-to-deploy/k8s/spinnaker/scripts/manage/connect_unsecured.sh
```

To connect to the Deck UI, click the link below, which highlights the Preview
button above.

<walkthrough-spotlight-pointer
    spotlightId="devshell-web-preview-button"
    text="Connect to Spinnaker via 'Preview on port 8080'">
</walkthrough-spotlight-pointer>


### Expose Spinnaker publicly

If you would like to connect to Spinnaker without relying on port forwarding, we can
expose it via a secure domain behind the [Identity-Aware Proxy](https://cloud.google.com/iap/).

```bash
~/click-to-deploy/k8s/spinnaker/scripts/expose/configure_endpoint.sh
```

### View Spinnaker Audit Log

View the who, what, when and where of your Spinnaker installation
[here](https://console.developers.google.com/logs/viewer?project={{project-id}}&resource=cloud_function&minLogLevel=200).

### Manage & Share Spinnaker

Now that you have provisioned Spinnaker, run this command to start managing
Spinnaker:

```bash
~/click-to-deploy/k8s/spinnaker/scripts/manage/update_console.sh
```

### Ongoing Management

When you want to manage Spinnaker in the future, you can always locate your Spinnaker installation
by navigating to the newly registered Kubernetes Application via the [Applications](https://console.developers.google.com/kubernetes/application?project={{project-id}}) view.

The application's *Next Steps* section contains the relevant links and operator instructions.
