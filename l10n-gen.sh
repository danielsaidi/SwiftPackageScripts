#!/bin/bash

# Documentation:
# This script will extract public keys for the Swift package.

# Define argument variables
PACKAGE=Sources/SwiftPackageScripts/
CATALOG=Resources/Localizable.xcstrings
FILE=_Generated/L10n+Generated.swift
SOURCE="$PACKAGE$CATALOG"
TARGET="$PACKAGE$FILE"

# Run the Swift CLI tool
./scripts/l10n-gen.sh --from $SOURCE --to $TARGET # --root sps
#./scripts/l10n-gen.sh --package $PACKAGE --catalog $CATALOG --target $FILE
