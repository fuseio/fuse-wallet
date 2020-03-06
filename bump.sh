#!/bin/bash
set -e

# Find and increment the version number.
perl -i -pe 's/^(version:\s+\d+\.\d+\.)(\d+)(\+)(\d+)$/$1.($2+1).$3.($4+1)/e' pubspec.yaml

# Commit and tag this change.
version=`grep 'version: ' pubspec.yaml | sed 's/version: //'`
git commit -m "Bump version to $version" pubspec.yaml
git tag $version
git push origin master --tags