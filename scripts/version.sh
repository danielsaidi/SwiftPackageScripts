#!/bin/bash

# Documentation:
# This script creates a new version for the provided <TARGET> and git <BRANCH>, 
# provided that it validates for all provided <PLATFORMS>.

# If no <BRANCH> is provided, "main" will be used.
# If no <PLATFORMS> are provided, all supported platforms are used.

# Usage:
# version <TARGET> <BRANCH> [<PLATFORMS> default:iOS macOS tvOS watchOS xrOS]"
# e.g. `version MyTarget master iOS macOS`

# The script will:
# * Validate the current git branch and its commit status.
# * Validate that the project builds for all <PLATFORMS>.
# * Validate that all unit tests pass for all <PLATFORMS>.
# * Call the version_bump.sh script to bump the version number if everything is OK.

# Exit immediately if a command exits with a non-zero status
set -e

# Verify that all required arguments are provided
if [ $# -lt 2 ]; then
    echo "Error: This script requires at least two arguments"
    echo "Usage: $0 <TARGET> <BRANCH>"
    echo "For instance: $0 MyTarget macOS"
    exit 1
fi

# Define argument variables
TARGET=$1
BRANCH=${2:-main}

# Remove TARGET and BRANCH from arguments list
shift
shift

# Read platform arguments or use default value
if [ $# -eq 0 ]; then
    set -- iOS macOS tvOS watchOS xrOS
fi

# Use the script folder to refer to the platform script.
FOLDER="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
VALIDATE_GIT="$FOLDER/version_validate_git.sh"
VALIDATE_PROJECT="$FOLDER/version_validate_project.sh"
VERSION_BUMP="$FOLDER/version_number_bump.sh"

# A function that run a certain script and checks for errors
run_script() {
    local script="$1"
    shift # Remove the first argument (the script path)

    if [ ! -f "$script" ]; then
        echo "Error: Script not found: $script"
        exit 1
    fi

    chmod +x "$script"
    if ! "$script" "$@"; then
        echo "Error: Script $script failed"
        exit 1
    fi
}

# Start script
echo ""
echo "Creating a new version for $TARGET on the $BRANCH branch..."
echo ""

# Validate git and project
echo "Validating..."
run_script "$VALIDATE_GIT" "$BRANCH"
run_script "$VALIDATE_PROJECT" "$TARGET"

# Bump version
echo "Bumping version..."
run_script "$VERSION_BUMP"

# Complete successfully
echo ""
echo "Version created successfully!"
echo ""
