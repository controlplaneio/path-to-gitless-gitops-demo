# 04 - Validating signature at deploy time with FluxCD

In this section we will leverage FluxCD to natively verify the signature of our OCI artifacts. The only step that we need to do is to [deploy our manifests](./01-deploy-application.sh). Within the [OCIRepository](./ocirepo.yaml) resource, the `.spec.verify` block references the key we create back in [the first section](../01-openbao-transit-engine/). This will automatically validate the signature of the OCI artifact. In the case of the unsigned OCI artifact, it will be rejected by FluxCD.

> [!IMPORTANT]
>
> FluxCD will verify the signature of the deployed artifact i.e. the Deployment manifest. However, it will not validate the signature of the container image. For that, you will need to use something else. More on that in the following sections.

> [!TIP]
>
> The `.spec.verify` field in an `OCIRepository` resource is optional. This means that if you want to enforce signature validation of these kinds of resources, you will need an additional policy that ensures that this field when deploy it to the cluster.

References:

- [FluxCD Docs - Source controllers - OCI Repositories](https://fluxcd.io/flux/components/source/ocirepositories/#verification)
