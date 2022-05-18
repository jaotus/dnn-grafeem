#!/usr/bin/env bash

# Create two images:
#   - for model "training" - $container-train
#   - "synthesis only" - $container

set -e
test -z "$1" &&  { echo "$LINENO: No container name" ; exit 1; }

container=$1
buildah rm $container || true

buildah from --name $container $container-base

echo "Copy tools & conda"
f=oss-cp.tmp
tee $f <<EOF >/dev/null
#!/usr/bin/env sh
mnt=\$(buildah mount $container)
cp -r Ossian-master \$mnt/Ossian
cp -r venv  \$mnt/
EOF
chmod u+x $f
buildah unshare ./$f
rm $f

buildah config --workingdir /Ossian $container
buildah config --volume /Ossian/voices $container
buildah config --volume /Ossian/corpus $container
buildah config --volume /Ossian/train $container
buildah config --volume /Ossian/test $container

buildah config --env LANG=C.utf8 $container
buildah config --env THEANO_FLAGS="" $container
buildah config --env USER=tester $container

echo "Create images"
buildah commit $container $container-train
buildah run $container -- sh -c 'rm /Ossian/tools/bin/H* /Ossian/tools/bin/hts_engine'
buildah commit --rm $container $container
podman image prune -f
echo -e "\nDone - images\n"

