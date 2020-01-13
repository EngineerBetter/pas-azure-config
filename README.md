# PAS Azure Config

An example of using [Platform Automation](https://docs.pivotal.io/platform-automation/v4.2/) to deploy [PAS](https://pivotal.io/platform/pivotal-application-service) on Microsoft Azure.

This repo contains foundation-specific files where the intention is that they will be "promoted" up through different environments. Non-foundation-specific files can be found in [pas-azure](https://github.com/EngineerBetter/pas-azure).

The intention is that once a an environment has been successfully deployed by `pipelines/deploy.yml` that all the config on the current branch is "promoted" up to a different branch which another pipeline is listening to.

## Config

The yaml file in the root of this repo are the various configuration files Platform Automation expects. They are at the top level of the repo because that is where Platform Automation tasks expect them to be by default.

|file|description|
|-|-|
|`auth.yml`|[For configuring ops manager authentication](https://docs.pivotal.io/platform-automation/v4.2/tasks.html#configure-authentication)|
|`director.yml`|[Configuration for the director tile](https://docs.pivotal.io/platform-automation/v4.2/inputs-outputs.html#director-config)|
|`env.yml`|[Credentials used by `om` to run authenticated commands](https://docs.pivotal.io/platform-automation/v4.2/inputs-outputs.html#env)|
|`opsman.yml`|[Configuration for the Ops Manager](https://docs.pivotal.io/platform-automation/v4.2/inputs-outputs.html#azure)|
|`pas.yml`|[Configuration for the pas tile](https://docs.pivotal.io/platform-automation/v4.2/inputs-outputs.html#product-config)|

### _Note on generating config files_

Generally a good shortcut for generating files like `director.yml` and `pas.yml` is to confgure them manually in the Ops Manager UI then use `om staged-director-config` or `om staged-config` to generate the yaml files. This still works with Platform Automation but keep in mind that the latest version of the Platform Automation image at time of writing (4.0.3) contains `om` version 3.1.0 while the latest `om` is 4.1.0.

If the `om` used for generating differs from the version used in the tasks then [weird issues can occur](https://github.com/pivotal-cf/om/issues/377).

One way around this is to use the image to run `om`:

```sh
docker run -it --rm platform-automation-image om ....
```

## Extra terraform

These have nothing to do with Platform Automation.

`add-dns.tf` links the DNS zone created by terraforming-azure to the one for <dns_suffix> by adding the appropriate NS record.

`extra-outputs.tf` defines some extra things I want to be able to `tfstate-interpolate` in my pipeline.

`self-signed-cert.tf` makes terraform create and manage some self-signed certs for use in pas.

## Deploy pipeline

Follow the [Pivotal docs](https://docs.pivotal.io/pivotalcf/2-8/om/azure/prepare-env-manual.html) to create an Azure Active Directory Application.

Note that Step 4, part 2 is incorrect. Your Service Princial requires "Owner" not "Contributor".

Ensure the following parameters are made available to the pipeline.

|credential|value|
|-|-|
|client_id|`az ad app list --identifier-uri "<your app uri>" \| jq -r '.[].appId'`|
|client_secret|The password of your app|
|configuration-branch|Branch of this repo to listen to|
|credhub-ca-cert|CA certificate of your credhub|
|credhub-client|Client configured with `credhub.read` and `credhub.write` in UAA|
|credhub-secret|Client secret of `credhub-client`|
|credhub-server|The URL of your credhub|
|dns_suffix|DNS suffix to use for this foundation (your Ops Manager will be on `pcf.$dns_suffix`)|
|github_access_token|GitHub Token to avoid rate limiting|
|github_private_key|Private key for your git repo(s)|
|location|Azure location to deploy into|
|parent_dns_rg|The resource group of the Azure DNS zone <dns_suffix>|
|resource_group|Name of Azure resource group for this foundation|
|storage_account_key|Key for your Azure storage account|
|storage_account_name|Name of your Azure storage account|
|subscription_id|`az account show \| jq -r '.id'`|
|tenant_id|`az account show \| jq -r '.tenantId'`|

For interpolation into config files ensure the following parameters are set in credhub on the path `<your resource group from above>/<parameter>`

|credential|value|
|-|-|
|opsman_password|password for your ops manager|
|opsman_decryption_passphrase|decryption passphrase for your ops manager|
