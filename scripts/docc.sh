#!/bin/bash

# Documentation:
# This script builds DocC for a <TARGET> for all provided <PLATFORMS>.
# If no <PLATFORMS> are defined, all supported platforms are used.
# The documentation ends up in to .build/docs-<PLATFORM>.

# Supported Platforms:
# iOS macOS tvOS watchOS xrOS

# Usage:
# build <TARGET> [<PLATFORMS> default:iOS macOS tvOS watchOS xrOS]
# e.g. `build MyTarget macOS`

# Exit immediately if a command exits with a non-zero status
set -e

# Verify that all required arguments are provided
if [ $# -eq 0 ]; then
    echo "Error: This script requires at least one argument"
    echo "Usage: $0 <TARGET> [<PLATFORMS> default:iOS macOS tvOS watchOS xrOS]"
    echo "For instance: $0 MyTarget macOS"
    exit 1
fi

# Define argument variables
TARGET=$1
TARGET_LOWERCASED=$(echo "$1" | tr '[:upper:]' '[:lower:]')

# Remove TARGET from arguments list
shift

# Read platform arguments or use default value
if [ $# -eq 0 ]; then
    set -- iOS macOS tvOS watchOS xrOS
fi

# Prepare the package for DocC
swift package resolve;

# A function that builds $TARGET for a specific platform
build_platform() {

    # Define a local $PLATFORM variable
    local PLATFORM=$1

    # Define the build folder name, based on the $PLATFORM
    case $PLATFORM in
        "iOS")
            DEBUG_PATH="Debug-iphoneos"
            ;;
        "macOS")
            DEBUG_PATH="Debug"
            ;;
        "tvOS")
            DEBUG_PATH="Debug-appletvos"
            ;;
        "watchOS")
            DEBUG_PATH="Debug-watchos"
            ;;
        "xrOS")
            DEBUG_PATH="Debug-xros"
            ;;
        *)
            echo "Error: Unsupported platform '$PLATFORM'"
            exit 1
            ;;
    esac

    # Build $TARGET docs for the $PLATFORM
    echo "Building $TARGET docs for $PLATFORM..."
    xcodebuild docbuild -scheme $TARGET -derivedDataPath .build/docbuild -destination 'generic/platform='$PLATFORM;

    # Transform docs for static hosting
    $(xcrun --find docc) process-archive \
      transform-for-static-hosting .build/docbuild/Build/Products/$DEBUG_PATH/$TARGET.doccarchive \
      --output-path .build/docs-$DEBUG_PATH \
      --hosting-base-path "$TARGET";

    # Inject a root redirect script on the root page
    echo "<script>window.location.href += \"/documentation/$TARGET_LOWERCASED\"</script>" > .build/docs-$DEBUG_PATH/index.html;

    # Complete successfully
    echo "Successfully built $TARGET docs for $PLATFORM"
}

# Loop through platforms and build
echo "Building $TARGET docs for [$@]..."
echo ""
for PLATFORM in "$@"; do
    if ! build_platform "$PLATFORM"; then
        exit 1
    fi
done

# Complete successfully
echo "Building $TARGET docs completed successfully!"