# 01 - OpenBao Transit Engine

The first step in this demo is to create the cryptographic key pair used to sign our artifacts. We will enable the OpenBao Transit Secrets Engine and use [Cosign to generate a key pair](./01-enable-transit-engine.sh). Because all cryptographic operations happen inside the Transit Engine, the private key never leaves OpenBao.

Later in the demo, Flux CD will need the public key stored in a [Kubernetes Secret](./02-create-public-key-secret.sh) to verify signatures.
Kyverno, on the other hand, integrates natively with OpenBao and verifies signatures directly against the Transit Engine.

> [!NOTE]
>
> **Signer vs. Verifier Trust Split:** Your terminal session simulates CI and holds signing permissions in OpenBao.
> Kyverno authenticates separately via [OpenBao Kubernetes Auth](https://openbao.org/docs/auth/kubernetes/) using a short-lived token mounted on `tmpfs` (`emptyDir: Memory`).
> Its `kyverno-verifier` policy grants only `read` on `transit/keys/gitless-gitops` and `update` on `transit/verify/gitless-gitops/*`.
> Even if the cluster is compromised, an attacker can only verify signatures—never forge them.
>
> **Caching & Availability Trade-off:** Referencing a KMS URI (`openbao://...`) disables Kyverno's in-memory verification cache so key rotations take effect immediately.
> Because every admission calls OpenBao live, control-plane namespaces must be excluded from policies so OpenBao downtime never blocks cluster recovery.

You can execute all of these steps with:

```sh
bash 01-enable-transit-engine.sh
bash 02-create-public-key-secret.sh
```

References:

- [Flux CD - Source Controllers - OCI Repositories](https://fluxcd.io/flux/components/source/ocirepositories/)
- [OpenBao - Transit Secrets Engine](https://openbao.org/docs/secrets/transit/)
- [Kyverno - Verify Image Rules](https://kyverno.io/docs/policy-types/cluster-policy/verify-images/overview/)
