# 01 - OpenBao Transit Engine

The first step in the demo will be to create the key that will be used to sign the different cryptographic operations. We will be using the OpenBao Transit Secrets Engine to [generate a key pair](./01-enable-transit-engine.sh). Since we are using the transit engine, you don't need to worry about handling the private key. In our case, we will be using Flux CD to perform some validations later on and it will need the key to be on a [Kubernetes secret](./02-create-public-key-secret.sh). Kyverno integrates natively with OpenBao, so there is no need to do anything else additionally for it.

You can execute all these commands with:

```sh
bash 01-enable-transit-engine.sh
bash 02-create-public-key-secret.sh
```

References:

- [FluxCD - Source Controllers - OCI Repositories](https://fluxcd.io/flux/components/source/ocirepositories/)
- [OpenBao - Transit secrets engine](https://openbao.org/docs/secrets/transit/)
- [Kyverno - Verify Image rules](https://kyverno.io/docs/policy-types/cluster-policy/verify-images/overview/)
