# 01 - OpenBao Transit Engine

The first step in the demo will be to create the key that will be used to sign the different cryptographic operations. We will be using the OpenBao Transit Secrets Engine to [generate a key pair](./01-enable-transit-engine.sh). As always, you should keep your private key secret, but we will be using the public key in the Kyverno policies later on. For that, [we will create a Kubernetes secret](./02-create-public-key-secret.sh) that can be accessed by the Kyverno policies.

You can deploy this entire section as:

```sh
bash 01-enable-transit-engine.sh
bash 02-create-public-key-secret.sh
```

References:

- [OpenBao - Transit secrets engine](https://openbao.org/docs/secrets/transit/)
- [Kyverno - Verify Image rules](https://kyverno.io/docs/policy-types/cluster-policy/verify-images/overview/)
