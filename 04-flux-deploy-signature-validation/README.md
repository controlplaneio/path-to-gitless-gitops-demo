# 04 - Validating signature at deploy time

In this section we will demonstrate how to leverage Flux CD and Kyverno to verify the signature of the OCI artifacts we intend to deploy. Note that both examples achieve the same outcome, just through different mechanisms.

## Flux CD

Flux CD providers a native resource called OCIRepository resource. Its `.spec.verify` block allows to specify a key to verify the cryptographic signatures of the deploy artifact. In [our example](./flux-ocirepo.yaml), it references the key we created back in [the first section](../01-openbao-transit-engine/). This will automatically validate the signature of the OCI artifact. In the case of the unsigned OCI artifact, it will be rejected by FluxCD.

```sh
bash ./01-deploy-and-flux-verify.sh
```

> [!TIP]
>
> The `.spec.verify` field in an `OCIRepository` resource is optional. This means that if you want to enforce signature validation of these kinds of resources, you will need an additional policy that ensures that this field when deploy it to the cluster.

## Kyverno

Kyverno can also verify the signature of the deployed OCI artifact. It does so via an `ImageValidatingPolicy` resource. The key parts of our example [policy](./kyverno-verify-oci-artifact-signature.yaml) are:

- `.spec.matchImageReferences` select which images are we looking for within `OCIRepository` resources.
- `.spec.attestors` configures the policy to leverage Cosign for attestion verification.
- `.spec.validations` specifies the validation clauses. In our case, we reject `OCIRepository` resources without artifacts (malformed), and verify that the provided OCI artifact is signed with the key we created.

```sh
bash ./02-deploy-and-kyverno-verify.sh
```

References:

- [FluxCD Docs - Source controllers - OCI Repositories](https://fluxcd.io/flux/components/source/ocirepositories/#verification)
- [Kyverno Docs - Policy Types - ImageValidatingPolicy](https://kyverno.io/docs/policy-types/image-validating-policy/)
