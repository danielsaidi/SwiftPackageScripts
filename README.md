<p align="center">
    <img src ="Resources/Logo_Rounded.png" alt="Swift Package Scripts Logo" />
</p>

<p align="center">
    <img src="https://img.shields.io/github/v/release/danielsaidi/SwiftPackageScripts?color=%2300550&sort=semver" alt="Version" title="Version" />
    <img src="https://img.shields.io/badge/swift-6.0-orange.svg" alt="Swift 6.0" title="Swift 6.0" />
    <img src="https://img.shields.io/github/license/danielsaidi/SwiftPackageScripts" alt="MIT License" title="MIT License" />
    <a href="https://twitter.com/danielsaidi"><img src="https://img.shields.io/twitter/url?label=Twitter&style=social&url=https%3A%2F%2Ftwitter.com%2Fdanielsaidi" alt="Twitter: @danielsaidi" title="Twitter: @danielsaidi" /></a>
    <a href="https://mastodon.social/@danielsaidi"><img src="https://img.shields.io/mastodon/follow/000253346?label=mastodon&style=social" alt="Mastodon: @danielsaidi@mastodon.social" title="Mastodon: @danielsaidi@mastodon.social" /></a>
</p>


# About Swift Package Scripts

This repository contains scripts that let you easily build and test your Swift Package, generate DocC documentation and XCFrameworks, and create new versions.


## Scripts

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


## GitHub integrations

The `.github/workflows` folder contains `build` and `docc` runner files, that are used by GitHub Actions to tests and update the GitHub hosted documentation on every push to the main branch.


## How to use these scripts

Note that `chmod +x` is required to use `./`, otherwise you have to use `bash ...`.

### Build and test

You can build and test a package or project with the `build` and `test` scripts:

```bash
./scripts/build.sh TARGET [PLATFORMS]
./scripts/test.sh TARGET [PLATFORMS]
```

### Generate DocC

You can generate DocC documentation for a package or project with the `docc` script:

```bash
./scripts/build.sh TARGET [PLATFORMS default: iOS macOS tvOS watchOS xrOS]
./scripts/test.sh TARGET [PLATFORMS]
```

### Generate XCFramework

You can generate an XCFramework for a project (not package) with the `framework` script:

```bash
./scripts/framework.sh TARGET [PLATFORMS default: iOS macOS tvOS watchOS xrOS]
```

### Create new versions

You can create a new version of your package or project with the `version` script:

```bash
./scripts/version.sh TARGET MAIN_BRANCH [PLATFORMS default: iOS macOS tvOS watchOS xrOS]
```

There are more version scripts that you can run standalone as well.


## Sample Package

This repository has a sample package that is used to test that everything works as expected.


## Documentation

You can find the generated, GitHub hosted documentation [here][Documentation].


[Documentation]: https://danielsaidi.github.io/SwiftPackageScripts/
