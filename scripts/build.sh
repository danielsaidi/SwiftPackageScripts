#!/bin/bash

# Documentation:
# This script builds a <TARGET> for all supported platforms.

# Usage:
# build <TARGET> [iOS macOS tvOS watchOS xrOS]
# e.g. `build MyTarget iOS tvOS`

# Exit immediately if a command exits with a non-zero status
set -e

# Verify that all required arguments are provided
if [ $# -eq 0 ]; then
    echo "Error: This script requires at least one argument"
    echo "Usage: $0 <TARGET> [platform1 platform2 ...]"
    echo "For instance: $0 MyTarget iOS macOS tvOS watchOS xrOS"
    exit 1
fi

# Define argument variables
TARGET=$1

# Remove TARGET from arguments list
shift

# Read platform arguments or use default value
if [ $# -eq 0 ]; then
    set -- iOS macOS tvOS watchOS xrOS
fi

# A function that builds $TARGET for a specific platform
build_platform() {
    local PLATFORM=$1
    echo "Building $TARGET for $PLATFORM..."
    if ! xcodebuild -scheme $TARGET -derivedDataPath .build -destination generic/platform=$PLATFORM; then
        echo "Failed to build $TARGET for $PLATFORM"
        return 1
    fi
    echo "Successfully built $TARGET for $PLATFORM"
}

# Loop through platforms and build
echo "Building $TARGET for [$@]..."
echo ""
for PLATFORM in "$@"; do
    if ! build_platform "$PLATFORM"; then
        exit 1
    fi
done

# Complete successfully
echo "Build completed successfully!"
