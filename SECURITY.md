# Security policy

## Supported versions

None. This repository documents one frozen, unmodified mirror of MinIO
`RELEASE.2021-02-14T04-01-33Z`. It will not be patched, rebuilt or updated.

## Known vulnerabilities

| ID | Summary |
|----|---------|
| [CVE-2023-28432](https://nvd.nist.gov/vuln/detail/CVE-2023-28432) | In distributed deployments, the cluster bootstrap endpoint discloses environment variables, including `MINIO_SECRET_KEY` and `MINIO_ROOT_PASSWORD`. Listed in the CISA Known Exploited Vulnerabilities catalog. |

This is not a complete list. Later MinIO releases fixed other issues that affect this version,
and the Red Hat UBI 8.3 base packages date from December 2020. Run an image scanner such as
`trivy image` or `grype` for the current picture.

## Recommendations

- Run single-node only, on a private network, never exposed to the internet.
- Use credentials that are unique to this deployment, and rotate them if the endpoint was ever
  reachable from untrusted networks.
- Move to a maintained object store.

## Reporting

Do not report MinIO vulnerabilities here. This repository cannot fix them. To report a mistake
in this mirror itself (wrong digest, missing notice), open an issue in this repository.
