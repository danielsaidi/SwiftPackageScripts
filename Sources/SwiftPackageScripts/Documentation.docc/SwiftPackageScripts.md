# ``SwiftPackageScripts``

## Overview

![SwiftPackageScripts logotype](Logo.png)

This repository contains Swift Package scripts that let you easily build and test your Swift Package, and generate new versions for it with a flexible `version_create` script.

These scripts replaces Fastlane for the most common tasks, to let you manage your entire CI/CD process without having to rely on Fastlane and Ruby. 

The repository also contains a `docc` script generates DocC documentation and prepare it for GitHub Pages. You can call it from your `.github/workflow` workflows to automatically publish documentation on each push.


## Scripts

The repository contains the following utility scripts:

The `scripts` filder contains the following scripts:

* `build.sh` - Run builds for all provided platforms.
* `chmod.sh` - Runs `chmod +x` on all scripts in the script folder.
* `docc.sh` - Build DocC documentation for all provided platforms.
* `framework.sh` - Build an XCFramework for all provided platforms.
* `git_default_branch.sh` - Get the default git branch name.
* `package_docc.sh` - Build DocC documentation for the main Swift package.
* `package_framework.sh` - Build an XCFramework for the main Swift package.
* `package_name.sh` - Get the name of the main Swift package.
* `package_version.sh` - Create a new version for the main Swift package.
* `test.sh` - Run the project unit tests for all provided platforms.
* `version.sh` - Create a new version with validation and test steps.
* `version_bump.sh` - Bump the version number and push a new version tag.
* `version_number.sh` - Get the current git version number.
* `version_validate_git.sh` - Validate that a git repo is ready for release.
* `version_validate_target.sh` - Validate that a target is ready for release.

Note that you may have to run `scripts chmod +x <SCRIPT>` to be able to run a script.



## Package-Specific Scripts

While these scripts cover many use-cases, you may still want to create project-specific scripts.

For instance, a closed-source package that only targets iOS could set up a release script that always generates DocC, an XCFramework and a new version tag for the package:

```swift
#!/bin/bash

# Documentation:
# This package-specific script builds a new release of the package.
# This script builds DocC, a framework, then creates a version tag.
# You can pass in a custom BRANCH to make the non-main branch pass validation.

# Usage:
# package_release.sh <BRANCH default:main>
# e.g. `bash scripts/package_release.sh master`

# Exit immediately if a command exits with non-zero status
set -e

# Get branch name
BRANCH_NAME_SCRIPT="scripts/git_default_branch.sh"
DEFAULT_BRANCH=$("$BRANCH_NAME_SCRIPT") || { echo "Failed to get branch name"; exit 1; }
BRANCH_NAME=${1:-$DEFAULT_BRANCH}

# Define platforms
PLATFORMS="iOS"

# Get package name
PACKAGE_NAME=$("scripts/package_name.sh") || { echo "Failed to get package name"; exit 1; }

# Build all package deliverables
bash "scripts/package_docc.sh" $PLATFORMS || { echo "DocC script failed"; exit 1; }
bash "scripts/package_framework.sh" $PLATFORMS || { echo "Framework script failed"; exit 1; }
bash "scripts/package_version.sh" $BRANCH_NAME || { echo "Version script failed"; exit 1; }

# Manual step - print checksum
echo ""
echo "***** CHECKSUM *****"
swift package compute-checksum .build/$PACKAGE_NAME.zip
echo "********************"
echo ""
```

This script mixed hard-coding certain always true factors, while allowing us to pass in a custom branch if needed.



## How to call scripts from the project root

You can call any script like this, with its supported arguments:

```bash
bash scripts/build [ProjectName]
```


## How to create new package versions

To create a new version of your package, just run this from the project root:

```bash
bash scripts/version_create.sh [ProjectName] [MainBranch]
```

To avoid having to type the project name and main branch, you can create a project-specific version script in your project root, that calls `version_create` with your project-specific target and branch.

You can then just do this:

```bash
bash version_create.sh
```

If the file sets up `chmod +x` for itself, you then only have to type this:

```bash
./version_create.sh
```

Have a look at the `version_create.sh` file in the repository root for an example.


## Sample Package

This repository has a sample package that is used to test that everything works as expected.
