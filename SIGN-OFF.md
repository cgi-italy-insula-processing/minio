# Redistribution sign-off: MinIO RELEASE.2021-02-14T04-01-33Z container image

## Status

| Field | Value |
|-------|-------|
| Status | **PENDING** CGI legal review |
| Requested by | Davide Foschi, CGI Italy, Insula processing team |
| Requested on | 2026-10-01 |
| Approver | _to be filled_ |
| Decision date | _to be filled_ |
| Decision reference | _to be filled_ |
| Conditions | _to be filled_ |

The technical analysis below is input to the review. It is not a legal opinion.

## Subject

CGI Italy republishes the upstream MinIO container image for release `RELEASE.2021-02-14T04-01-33Z`
on the GitHub Container Registry under the `cgi-italy-insula-processing` organisation:

```
ghcr.io/cgi-italy-insula-processing/minio:RELEASE.2021-02-14T04-01-33Z
sha256:d5c9deb6e510089a81447c91a61c6383928aacc84a9a0834e6ff8548b10084b0  (linux/amd64)
```

The image is redistributed **unmodified**. It is a copy of the image that MinIO, Inc. built and
published on 2021-02-14, taken from CGI's internal registry mirror. The manifest digest is
unchanged, and the provenance evidence is in the [README](README.md#provenance). The upstream
channels no longer serve this release, and the Insula processing Helm chart depends on it.

## Components in the image

| Component | Origin | License | Notice |
|-----------|--------|---------|--------|
| MinIO server binary `/usr/bin/minio`, entrypoint and verify scripts | MinIO, Inc., git tag `RELEASE.2021-02-14T04-01-33Z`, commit `c4e12dc846ca04c03cab9de69c828b1351631cfc` | Apache License 2.0 | `LICENSE` at the tag starts "Apache License, Version 2.0, January 2004" |
| Go dependencies compiled into the binary | various | various permissive licenses, as listed upstream | Full texts in `/licenses/CREDITS` inside the image, byte-identical to `CREDITS` at the tag |
| Base layers | Red Hat, `ubi8/ubi-minimal:8.3-230` | Red Hat UBI EULA | Image label `com.redhat.license_terms`. The UBI image describes itself as "freely redistributable" |
| `minisign` RPM | Fedora EPEL 8 | ISC | Installed by the upstream build |

MinIO moved to AGPLv3 in April 2021, and the move was complete with `RELEASE.2021-05-11T23-27-41Z`.
This release predates it, so the Apache 2.0 terms apply.

## Apache License 2.0, section 4: obligations and how they are met

| Clause | Requirement | How it is met |
|--------|-------------|---------------|
| 4(a) | Give recipients a copy of the License | `/licenses/LICENSE` inside the image, plus [LICENSE](LICENSE) in this repository |
| 4(b) | Modified files carry prominent change notices | Not applicable: nothing is modified |
| 4(c) | Keep copyright, patent, trademark and attribution notices | The image is unmodified, so all upstream notices and labels are kept |
| 4(d) | Include the NOTICE file with the distribution | Upstream did not copy NOTICE into the image. A verbatim copy is published here as [NOTICE](NOTICE), in the repository linked to the package |
| 6 | No trademark rights granted | The name "MinIO" only identifies the software. The README and this file state that the mirror is not affiliated with or endorsed by MinIO, Inc. |

## Red Hat UBI

The base layers are Red Hat's published UBI 8 Minimal 8.3-230 layers, unmodified (same layer
digests as `registry.access.redhat.com/ubi8/ubi-minimal:8.3-230`). The UBI EULA permits
redistribution of UBI-based images. It restricts the use of Red Hat trademarks and does not
let us imply Red Hat support. Neither is claimed here.

## Security disclosure

This release is affected by CVE-2023-28432 (CISA KEV), and its base layers have not been updated
since December 2020. It is published as unpatched legacy software, without support, and the
warning is in the [README](README.md) and [SECURITY.md](SECURITY.md). No fixed version will be
published under this name.

## Questions for the reviewer

1. Is redistribution of an unmodified Apache 2.0 image with the NOTICE published alongside it,
   rather than inside it, acceptable to CGI?
2. Is the trademark disclaimer wording sufficient?
3. Is publishing an image with a known exploited vulnerability acceptable, given the warnings
   and the stated purpose (keeping pinned deployments working)?
4. Does CGI require a CGI copyright or contact line in this repository?

## Record

Once a decision is made, fill in the Status table above in a commit that references the decision.
If the decision is negative, make the package and this repository private.
