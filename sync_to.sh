#!/bin/bash

# Documentation:
# This script syncs Swift Package Scripts to a <FOLDER>.
# This script will overwrite any existing folder with this one.

# Usage:
# package_name.sh <FOLDER>
# e.g. `bash sync_to.sh ../MyPackage`

# Define argument variables
TARGET=$1

# Define variables
FOLDER="scripts/"
TARGET_FOLDER="$TARGET/$FOLDER"

# Start script
echo ""
echo "Syncing scripts to $TARGET_FOLDER..."
echo ""

# Remove existing folder
rm -rf "$TARGET_FOLDER"

# Copy folder
cp -r "$FOLDER/" "$TARGET_FOLDER/"

# Complete successfully
echo ""
echo "Script syncing to $TARGET_FOLDER completed successfully!"
echo ""
