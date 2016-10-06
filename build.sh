#!/bin/bash -e

version=$(cat version)
online_md5=$(cat md5)
filename=balance-${version}.tar.gz

function cleanup {
  rm ${filename}
  rm -f Dockerfile.build
}
trap cleanup EXIT

echo 'Downloading balance'
curl -s http://www.inlab.de/${filename} > ${filename}

echo 'Verifying MD5 of download'
local_md5=$(md5sum "$filename" | awk '{print $1}')
if [ "$online_md5" != "$local_md5" ]; then
  echo MD5 mismatch
  exit 1
fi

echo 'Building binary'
tar zxf ${filename}
cd balance-${version}
make
cd ..

echo 'Preparing Dockerfile'
cat Dockerfile | sed s/\$\{VERSION\}/3.57/ > Dockerfile.build

echo 'Building Docker image'
VERSION=${version} docker build -f Dockerfile.build -t lukebond/docker-balance .
rm Dockerfile.build
