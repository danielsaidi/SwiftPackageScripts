#!/bin/bash

# Documentation:
# This script creates a new project version for the current project.
# You can customize this to fit your project when you copy these scripts.
# You can pass in a custom <BRANCH> if you don't want to use the default one.

TARGET="SwiftPackageScripts"
PLATFORMS="iOS macOS tvOS watchOS xrOS"
BRANCH=${1:-"main"}
SCRIPT="scripts/version.sh"
chmod +x $SCRIPT
bash $SCRIPT $TARGET $BRANCH $PLATFORMS
