#!/bin/sh
# Verify that the mirrored image is the unmodified upstream MinIO release.
# Requires: skopeo, docker, curl, sha256sum, minisign.
set -eu

TAG=RELEASE.2021-02-14T04-01-33Z
IMG=${IMG:-ghcr.io/cgi-italy-insula-processing/minio:$TAG}
EXPECTED_DIGEST=d5c9deb6e510089a81447c91a61c6383928aacc84a9a0834e6ff8548b10084b0
REL=https://github.com/minio/minio/releases/download/$TAG
BIN=minio.linux-amd64.$TAG
PUBKEY=RWTx5Zr1tiHQLwG9keckT0c45M3AGeHD6IvimQHpyRywVWGbP1aVSGav
CTR=minio-verify-$$

for t in skopeo docker curl sha256sum minisign; do
  command -v "$t" >/dev/null 2>&1 || { echo "missing required tool: $t" >&2; exit 1; }
done

WORK=$(mktemp -d)
trap 'docker rm -f "$CTR" >/dev/null 2>&1 || true; rm -rf "$WORK"' EXIT
cd "$WORK"

fail() { echo "FAIL: $*" >&2; exit 1; }

skopeo inspect --raw "docker://$IMG" > manifest.json || fail "cannot read manifest of $IMG"
digest=$(sha256sum manifest.json | cut -d' ' -f1)
[ "$digest" = "$EXPECTED_DIGEST" ] || fail "manifest digest $digest, expected $EXPECTED_DIGEST"
echo "OK   manifest digest $digest"

curl -sSfLO "$REL/$BIN"
curl -sSfLO "$REL/$BIN.minisig"
minisign -Vqm "$BIN" -x "$BIN.minisig" -P "$PUBKEY" || fail "minisign signature of release asset"
echo "OK   release asset signed by $PUBKEY"

docker create --name "$CTR" --platform linux/amd64 "$IMG" >/dev/null
docker cp "$CTR:/usr/bin/minio" ./minio.image
image_sha=$(sha256sum ./minio.image | cut -d' ' -f1)
asset_sha=$(sha256sum "$BIN" | cut -d' ' -f1)
[ "$image_sha" = "$asset_sha" ] || fail "image binary $image_sha differs from release asset $asset_sha"
echo "OK   /usr/bin/minio equals $BIN ($image_sha)"

echo "PASS $IMG is the unmodified upstream $TAG image"
