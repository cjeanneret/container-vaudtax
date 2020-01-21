#!/bin/sh

year=$(date -d '-1year' '+%Y')
last_year=$(date -d '-2year' '+%Y')
podman images vaudtax${yera} | grep -q "localhost/vaudtax${year}" || podman build -t vaudtax${year} $(dirname "$0")

mkdir -p ~/VaudTax${year} ~/VaudTax${last_year}
podman unshare chown -R 1000:1000 ~/VaudTax${year} ~/VaudTax${last_year}

podman run --rm -ti \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v ~/VaudTax${year}:/home/tax/VaudTax${year}:rw \
  -v ~/VaudTax${last_year}:/home/tax/VaudTax${last_year}:rw \
  -e DISPLAY=unix$DISPLAY \
  --name VaudTax \
  localhost/vaudtax \
  ./VaudTax_2019-1.0.2-production-64bit/vaudtax-2019
