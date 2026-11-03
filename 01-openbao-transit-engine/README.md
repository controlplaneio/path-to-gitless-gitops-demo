# 01 - OpenBao Transit Engine

The first step in this demo is to create the cryptographic key pair used to sign our artifacts. We will enable the OpenBao Transit Secrets Engine and use [Cosign to generate a key pair](./01-enable-transit-engine.sh). Because all cryptographic operations happen inside the Transit Engine, the private key never leaves OpenBao.

Later in the demo, Flux CD will need the public key stored in a [Kubernetes Secret](./02-create-public-key-secret.sh) to verify signatures. Kyverno, on the other hand, integrates natively with OpenBao and can query the key directly without requiring a Kubernetes Secret.

You can execute all of these steps with:

```sh
bash 01-enable-transit-engine.sh
bash 02-create-public-key-secret.sh
```

References:

- [Flux CD - Source Controllers - OCI Repositories](https://fluxcd.io/flux/components/source/ocirepositories/)
- [OpenBao - Transit Secrets Engine](https://openbao.org/docs/secrets/transit/)
- [Kyverno - Verify Image Rules](https://kyverno.io/docs/policy-types/cluster-policy/verify-images/overview/)
