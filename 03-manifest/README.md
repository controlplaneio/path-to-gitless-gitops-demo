# 03 - Creating a manifest for our simple App

> [!IMPORTANT]
>
> Do not forget to apply [the environment variables](./00-manifest-env-vars.sh), since these will be used throghout the playground:
>
> ```sh
> source ./00-manifest-env-vars.sh
> ```

In this section, we will proceed with [creating a simple deployment](./01-create-manifest.sh) for our simple App. Following on as we did with the simple App, we will [package it as an OCI artifact](./02-create-and-push-oci-artifact.sh) and create [a signed and an unsiged version](./03-sign-kube-manifest.sh).

```sh
source ./00-manifest-env-vars.sh
bash ./01-create-manifest.sh
bash ./02-create-and-push-oci-artifact.sh
bash ./03-sign-kube-manifest.sh
```
