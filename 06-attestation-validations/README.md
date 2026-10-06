# 06 - Attestation verifications

> [!NOTE]
>
> This section assumes that you have the Kyverno policies to validate image and manifest signature still deployed.

It is now time to leverage attestations. We have already proven that the workloads we deployed were created by a trusted party. We now have to verify that these workloads are up to the standards we expect them to be at.

All of the policies within this section are a very close variation of each other. The important parts are:

- The `.spec.attestations` block defines the attestation that we are verifying.
- The `.spec.validations` has custom CEL policies that target fields within the specific attestation.

> [!TIP]
>
> In-toto predicate types are referred to via a given URL. It is worth noting that these URLs are not necessarily valid. Instead, [they act as identifiers](http://github.com/in-toto/attestation/blob/main/spec/v1/statement.md) of the type of the predicate.

## Test attestation

The first attestation type we will be looking at the test type. This is a predefined [in-toto predicate](https://in-toto.io/attestation/test-result/v0.1) that cosign and Kyverno both natively support. All that is required is to present [a predicate](./test_result.json). This predicate is simply a JSON file that we constructed to be compliant with the specification, but in practice you will need to construct this with information relative to your specific test run. Once the predicate is ready, we can [cryptographically attest it using cosign](./02-attest-and-tree-with-cosign.sh).

To see the Kyverno policy in action run the commands in the following order:

```sh
bash ./01-cleanup.sh                            # Clean resources from previous sections
bash ./02-kyverno-test-attestation-policy.sh    # Deploy Kyverno policy to validate test attestation
bash ./03-deploy-workload.sh                    # Deploy our unattested workload. Will fail
bash ./04-test-attestation.sh                   # Attest the workload
bash ./01-cleanup.sh                            # Clean resources to start with a clean slate
bash ./03-deploy-workload.sh                    # Deploy our attested workload. Will succeed
```

## SBOM

Following, we will demonstrate how to verify an SBOM using attestations. In this case, in-toto supports both [SPDX](https://github.com/in-toto/attestation/blob/main/spec/predicates/spdx3.md) and [CycloneDX](https://github.com/in-toto/attestation/blob/main/spec/predicates/cyclonedx.md) formats. We will be using SPDX in our example and use [Trivy to generate the file](./06-sbom-attestation.sh).

To see the Kyverno policy in action run the commands in the following order:

```sh
bash ./01-cleanup.sh                            # Clean resources from previous sections
bash ./05-kyverno-sbom-attestation-policy.sh    # Deploy SBOM Kyverno policy
bash ./03-deploy-workload.sh                    # Deploy our workload. Will fail
bash ./06-sbom-attestation.sh                   # Attest the workload
bash ./03-deploy-workload.sh                    # Deploy our workload. Will succeed
```

> [!TIP]
>
> Go check the attestation generated for the SBOM. You will notice that, instead of referring to the SBOM file, the actual contents of the SBOM are embedded within the attestation. This means that you can actually leverage CEL to access the fields within the attestation and have even more granular expressions depending on the reported components.

## Vulnerabilities

Most organization will have a strict policy around what CVE types can be shipped to production. The [vulnerabilities attestation](https://github.com/in-toto/attestation/blob/main/spec/predicates/vulns_02.md) helps with admission of workloads by verifying whether the workloads can actually be deployed to production with their reported vulnerabilities. You only need to [generate the vulnerabilities report](./08-vuln-attestation.sh) with a vulnerabilities scanner, such as Trivy, and attach it as an attestation.

To see the Kyverno policy in action run the commands in the following order:

```sh
bash ./01-cleanup.sh                            # Clean resources from previous sections
bash ./07-kyverno-vuln-attestation-policy.sh    # Deploy Vuln Kyverno policy
bash ./03-deploy-workload.sh                    # Deploy our workload. Will fail
bash ./08-vuln-attestation.sh                   # Attest the workload
bash ./03-deploy-workload.sh                    # Deploy our workload. Will succeed
```

## Custom

Cosign also supports a [custom type of in-toto predicate](https://github.com/sigstore/cosign/blob/main/doc/cosign_attest.md). This means that you can create your own predicates and attest them cryptographically for internal use. If you want, you could also submit it to become one of the [vetted in-toto predicates](https://github.com/in-toto/attestation/blob/main/docs/new_predicate_guidelines.md). Custom in-toto predicates are outside of the scope of this playground, so we will not be covering them. However, it is worth knowing they exist!

## References

- [In-toto attestation - Predicates - Spec - SPDX](https://github.com/in-toto/attestation/blob/main/spec/predicates/spdx3.md)
- [In-toto attestation - Predicates - Spec - Test](https://github.com/in-toto/attestation/blob/main/spec/predicates/test-result.md)
- [In-toto attestation - Predicates - Spec - Vulnerabilities](https://github.com/in-toto/attestation/blob/main/spec/predicates/vuln.md)
- [Kyverno Docs - Policy Types - ImageValidatingPolicy](https://kyverno.io/docs/policy-types/image-validating-policy/)
- [Trivy Docs - SBOM Scanning](http://trivy.dev/docs/latest/target/sbom/)
