# 02 - Creating a simple App image

We will be creating a [simple aplication](./01-build-and-push.sh). This script will create two versions of the app, one that we [will sign](./02-sign-and-tree-with-cosign.sh) and one that will be left unsigned.

You can deploy this entire section as follows:

```sh
bash ./01-build-and-push.sh
bash ./02-sign-and-tree-with-cosign.sh
```

References:

- [Podman Docs - Build command](https://docs.podman.io/en/v5.5.2/markdown/podman-build.1.html)
- [GitHub - Sigstore/Cosign - Sign command](https://github.com/sigstore/cosign/blob/main/doc/cosign_sign.md)
