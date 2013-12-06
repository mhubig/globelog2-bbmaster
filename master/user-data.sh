Content-Type: text/x-shellscript
docker build -t mhubig/globelog2-bbslave {BUILDBOT_REPO}
docker run -i -t \
    -v /mnt:/data/slave/build \
    -e BUILDBOT_ADDR="{BUILDBOT_ADDR}" \
    -e BUILDBOT_PORT="{BUILDBOT_PORT}" \
    -e BUILDBOT_PASS="{BUILDBOT_PASS}" \
    mhubig/globelog2-bbslave
