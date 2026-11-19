# path-to-gitless-gitops-demo

An end-to-end journey from basics to a Gitless GitOps implementation.

## Architecture & Scope

In this workshop, application manifests are packaged, signed, and reconciled strictly as OCI artifacts with no Git repository in the loop.
In production, Flux also reconciles policies and tenant `OCIRepository` / `Kustomization` resources from a signed root OCI config artifact (`flux-system/config`).
Here, Sections `04`–`06` apply those top-level resources with `kubectl apply` as an interactive test harness so you can compare admission and reconciliation side by side.

## Workshop Sections

1. [01 - OpenBao Transit Engine](./01-openbao-transit-engine/) — Generate a KMS-backed Cosign key pair in OpenBao.
2. [02 - A Simple App Image](./02-a-simple-app-image/) — Build, push, and sign an application container image.
3. [03 - Manifest](./03-manifest/) — Package and sign Kubernetes manifests as OCI artifacts.
4. [04 - Manifest Signature Verification](./04-manifest-signature-verification/) — Verify OCI manifest signatures with Flux CD and Kyverno.
5. [05 - Image Signature Verification](./05-image-signature-verification/) — Enforce container image signature checks at admission time.
6. [06 - Attestation Validations](./06-attestation-validations/) — Validate test result, SBOM, and vulnerability attestations with Kyverno.

## Setup

Before beginning your journey, ensure you have the required environment variables loaded in your active shell session. Run the environment setup script to append them to your `~/.bashrc`:

```sh
bash setup-env.sh
source ~/.bashrc
```
