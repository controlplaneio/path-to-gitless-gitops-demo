# 02 - Creating a Simple App Image

With the signing key created, we can now build and push a [simple application image](./01-build-and-push.sh). This script pushes two tags of the application image: one that we [will sign with Cosign](./02-sign-and-tree-with-cosign.sh), and one that we will leave unsigned.

You can run this entire section as follows:

```sh
bash ./01-build-and-push.sh
bash ./02-sign-and-tree-with-cosign.sh
```

References:

- [Podman Docs - Build command](https://docs.podman.io/en/v5.5.2/markdown/podman-build.1.html)
- [GitHub - Sigstore/Cosign - Sign command](https://github.com/sigstore/cosign/blob/main/doc/cosign_sign.md)
