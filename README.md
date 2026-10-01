# MinIO RELEASE.2021-02-14T04-01-33Z (unofficial mirror)

This repository documents an **unofficial, unmodified mirror** of the upstream MinIO container image
`RELEASE.2021-02-14T04-01-33Z`, published at:

```
ghcr.io/cgi-italy-insula-processing/minio:RELEASE.2021-02-14T04-01-33Z
ghcr.io/cgi-italy-insula-processing/minio@sha256:d5c9deb6e510089a81447c91a61c6383928aacc84a9a0834e6ff8548b10084b0
```

Platform: `linux/amd64` only.

> **Warning: unpatched legacy software.**
> This release is affected by [CVE-2023-28432](https://nvd.nist.gov/vuln/detail/CVE-2023-28432)
> (information disclosure of environment variables, including root credentials, in distributed
> deployments; listed in the CISA Known Exploited Vulnerabilities catalog). The Red Hat UBI 8.3
> base layers are from December 2020 and have not been updated. Do not expose this image to
> untrusted networks. It is provided only so that existing deployments pinned to this exact
> version keep working.

> **Not affiliated with MinIO, Inc.**
> This mirror is not produced, endorsed or supported by MinIO, Inc. "MinIO" is a trademark of
> MinIO, Inc. and is used here only to identify the software. The image labels
> (`vendor="MinIO Inc"`, `maintainer=...`) are upstream's original metadata and were left
> untouched on purpose.

## Why this mirror exists

The upstream distribution channels for this release are no longer available: the Docker Hub
`minio/minio` repository was removed, `quay.io/minio/minio` no longer allows anonymous pulls, and
`dl.min.io` no longer serves the binaries. The Insula processing
[`helm-chart`](https://github.com/cgi-italy-insula-processing/helm-chart) deploys this version,
so we republish the original image unchanged.

## Provenance

The image is a byte-for-byte copy of the upstream image (same manifest digest). It was checked
against the official GitHub release
[RELEASE.2021-02-14T04-01-33Z](https://github.com/minio/minio/releases/tag/RELEASE.2021-02-14T04-01-33Z)
(commit `c4e12dc846ca04c03cab9de69c828b1351631cfc`):

| Check | Result |
|-------|--------|
| `/usr/bin/minio` SHA256 | `9c6a4b92a7c5733bcb5e2bbbbb44cadced61ae65f9cc2254a47882113c4e7908`, identical to the release asset `minio.linux-amd64.RELEASE.2021-02-14T04-01-33Z` |
| minisign signature | valid for public key `RWTx5Zr1tiHQLwG9keckT0c45M3AGeHD6IvimQHpyRywVWGbP1aVSGav` (from `Dockerfile.release` at the tag) |
| GPG signature | valid, key `4405 F3F0 DDBA 1B9E 68A3 1D25 12C7 4390 F9AA C728` (`Minio Trusted <trusted@minio.io>`) |
| Embedded commit | `c4e12dc846ca04c03cab9de69c828b1351631cfc` |
| Base layers | identical to `registry.access.redhat.com/ubi8/ubi-minimal:8.3-230` |
| Build history | matches upstream `Dockerfile.release`. The LABEL version is taken from upstream commit `cfc8b92dff1afe22e195cbafb80d86380672a638`, a label-only change directly on top of the release commit |
| `/usr/bin/docker-entrypoint.sh`, `/licenses/LICENSE`, `/licenses/CREDITS` | byte-identical to the tag |

### Verify it yourself

```sh
IMG=ghcr.io/cgi-italy-insula-processing/minio:RELEASE.2021-02-14T04-01-33Z
REL=https://github.com/minio/minio/releases/download/RELEASE.2021-02-14T04-01-33Z
BIN=minio.linux-amd64.RELEASE.2021-02-14T04-01-33Z

skopeo inspect --raw "docker://$IMG" | sha256sum
# expected: d5c9deb6e510089a81447c91a61c6383928aacc84a9a0834e6ff8548b10084b0

docker create --name minio-check --platform linux/amd64 "$IMG"
docker cp minio-check:/usr/bin/minio ./minio.image
docker rm minio-check

curl -sSfLO "$REL/$BIN"
curl -sSfLO "$REL/$BIN.minisig"
sha256sum ./minio.image "$BIN"
minisign -Vm "$BIN" -x "$BIN.minisig" -P RWTx5Zr1tiHQLwG9keckT0c45M3AGeHD6IvimQHpyRywVWGbP1aVSGav
```

## Usage

This release still uses the legacy credential variables `MINIO_ACCESS_KEY` and `MINIO_SECRET_KEY`.
`MINIO_ROOT_USER` and `MINIO_ROOT_PASSWORD` are also accepted.

```sh
docker run -d --name minio -p 9000:9000 \
  -e MINIO_ACCESS_KEY=<access-key> -e MINIO_SECRET_KEY=<secret-key> \
  ghcr.io/cgi-italy-insula-processing/minio:RELEASE.2021-02-14T04-01-33Z server /data
curl -sf http://localhost:9000/minio/health/live
```

Helm values for the Insula processing chart:

```yaml
minio:
  image:
    repository: ghcr.io/cgi-italy-insula-processing/minio
    tag: RELEASE.2021-02-14T04-01-33Z
```

## License

MinIO `RELEASE.2021-02-14T04-01-33Z` is licensed under the Apache License, Version 2.0, since it
predates MinIO's move to AGPLv3. [LICENSE](LICENSE) and [NOTICE](NOTICE) in this repository are
verbatim copies from the upstream tag. The image ships the license and the third-party license
texts as `/licenses/LICENSE` and `/licenses/CREDITS`.

The base layers are Red Hat Universal Base Image 8 Minimal and are covered by the
[Red Hat UBI End User License Agreement](https://www.redhat.com/en/about/red-hat-end-user-license-agreements#UBI).

## Support

None. No fixes or updates will be published for this image. Upgrade to a maintained object store
as soon as you can.
