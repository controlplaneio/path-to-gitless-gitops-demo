# 06 - Attestation validations

> [!NOTE]
>
> This section assumes the Kyverno policies for validating manifest and image signatures from the previous sections are still deployed.

Now that we have cryptographically proven our workloads were created by a trusted party, we can leverage attestations to verify that they meet our quality and security standards before admission.

All of the policies in this section follow the same pattern. Their key components are:

- The `.spec.attestations` block defines the attestation predicate type to verify.
- The `.spec.validations` block defines custom CEL expressions that inspect specific fields inside the verified attestation payload.

> [!TIP]
>
> In-toto predicate types are identified by URLs. Note that these URLs do not necessarily resolve to live web pages; instead, [they act as unique URI identifiers](https://github.com/in-toto/attestation/blob/main/spec/v1/statement.md) for the predicate schema.

## Test Attestation

The first attestation type we will look at is the test result predicate. This is a predefined [in-toto predicate](https://in-toto.io/attestation/test-result/v0.1) natively supported by both Cosign and Kyverno. To use it, we provide [a predicate payload](./test_result.json)—a JSON file structured according to the specification (in a real CI/CD pipeline, your test runner would generate this dynamically). Once the predicate file is ready, we can [cryptographically attest and attach it using Cosign](./04-test-attestation.sh).

To see the Kyverno policy in action, run the commands in the following order:

```sh
bash ./01-cleanup.sh                            # Clean resources from previous sections
bash ./02-kyverno-test-attestation-policy.sh    # Deploy Kyverno policy to validate test attestation
bash ./03-deploy-workload.sh                    # Deploy our unattested workload (will fail)
bash ./04-test-attestation.sh                   # Attest the workload
bash ./01-cleanup.sh                            # Clean resources to start with a clean slate
bash ./03-deploy-workload.sh                    # Deploy our attested workload (will succeed)
```

## SBOM

Next, we will demonstrate how to verify a Software Bill of Materials (SBOM) using attestations. In-toto supports both [SPDX](https://github.com/in-toto/attestation/blob/main/spec/predicates/spdx3.md) and [CycloneDX](https://github.com/in-toto/attestation/blob/main/spec/predicates/cyclonedx.md) formats. In our example, we use SPDX and [run Trivy to generate and attest the SBOM](./06-sbom-attestation.sh).

To see the Kyverno policy in action, run the commands in the following order:

```sh
bash ./01-cleanup.sh                            # Clean resources from previous sections
bash ./05-kyverno-sbom-attestation-policy.sh    # Deploy SBOM Kyverno policy
bash ./03-deploy-workload.sh                    # Deploy our workload (will fail)
bash ./06-sbom-attestation.sh                   # Attest the workload
bash ./01-cleanup.sh                            # Clean resources to start with a clean slate
bash ./03-deploy-workload.sh                    # Deploy our workload (will succeed)
```

> [!TIP]
>
> Inspect the generated SBOM attestation! Notice that instead of merely linking to an external file, the entire SBOM payload is embedded directly inside the attestation statement. This allows you to write granular CEL expressions in Kyverno that inspect specific packages, versions, or licenses within the SBOM at admission time.

## Vulnerabilities

Most organizations enforce strict policies around which CVEs or severity levels are allowed in production. A [vulnerability scan attestation](https://github.com/in-toto/attestation/blob/main/spec/predicates/vulns_02.md) allows admission controllers to verify whether an image complies with vulnerability thresholds before deployment. You simply [generate the vulnerability report](./08-vuln-attestation.sh) using a scanner like Trivy and attach it to the image as a signed attestation.

To see the Kyverno policy in action, run the commands in the following order:

```sh
bash ./01-cleanup.sh                            # Clean resources from previous sections
bash ./07-kyverno-vuln-attestation-policy.sh    # Deploy Vuln Kyverno policy
bash ./03-deploy-workload.sh                    # Deploy our workload (will fail)
bash ./08-vuln-attestation.sh                   # Attest the workload
bash ./01-cleanup.sh                            # Clean resources to start with a clean slate
bash ./03-deploy-workload.sh                    # Deploy our workload (will succeed)
```

## Custom

Cosign also supports [custom in-toto predicates](https://github.com/sigstore/cosign/blob/main/doc/cosign_attest.md). This allows you to define your own JSON schemas and cryptographically attest arbitrary metadata for internal platform guardrails. You can even submit general-purpose schemas to become [vetted in-toto predicates](https://github.com/in-toto/attestation/blob/main/docs/new_predicate_guidelines.md). While custom predicates are outside the scope of this playground, they are a powerful capability to keep in mind.

## References

- [In-toto Attestation - Predicates - Spec - SPDX](https://github.com/in-toto/attestation/blob/main/spec/predicates/spdx3.md)
- [In-toto Attestation - Predicates - Spec - Test Result](https://github.com/in-toto/attestation/blob/main/spec/predicates/test-result.md)
- [In-toto Attestation - Predicates - Spec - Vulnerabilities](https://github.com/in-toto/attestation/blob/main/spec/predicates/vulns_02.md)
- [Kyverno Docs - Policy Types - ImageValidatingPolicy](https://kyverno.io/docs/policy-types/image-validating-policy/)
- [Trivy Docs - SBOM Scanning](https://trivy.dev/docs/latest/target/sbom/)
