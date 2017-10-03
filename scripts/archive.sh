#!/bin/bash

ROOT_PATH=$(eval git rev-parse --show-toplevel)
cd "${ROOT_PATH}"

swift build -c release

rm -rf "tmp"
mkdir -p "tmp/bin"

cp ".build/release/kve" "tmp/bin/"
cp -r "resources" "tmp"

cd "tmp"
zip -r "../kve.zip" *
cd -

rm -rf "tmp"
