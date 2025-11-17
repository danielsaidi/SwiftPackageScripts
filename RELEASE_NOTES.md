# RELEASE NOTES

[Swift Package Scripts](https://github.com/danielsaidi/SwiftPackageScripts) honors semantic versioning, with the following strategy:

* Deprecations can happen at any time.
* Deprecations are removed in `major` updates.
* Breaking changes should only occur in `major` updates.
* Breaking changes *can* occur in `minor` and `patch` updates, if the alternative is worse.

Beta version tags and releases are removed after the next minor or major version. 


## 1.2

This version adds a  updates `xcframework-binaries.yml` to upload unzipped files.

The binary artifact workflow has been adjusted to upload a container zip file, to avoid data loss.

## ✨ Features

* `version_bump.yml` is a new GitHub Actions workflow.
* `version_bump.sh` has new `--type` and `--version` parameters.

## 💡 Changes

* `xcframework-binaries.yml` is reneamed to `binary_artifacts.yml`.
* `xcframework-binaries.yml` now uploads a container zip file that needs additional handling.



## 1.1.1

This version updates `xcframework-binaries.yml` to upload unzipped files.

## ✨ Features

* `framework.sh` has a new `--zip` parameter.

## 💡 Changes

* `xcframework-binaries.yml` calls `framework.sh` with `--zip 0`.



## 1.1

This version adds a new `xcframework.yml` GitHub workflow template, and adds new script parameters.

## ✨ Features

* `xcframework.yml` is a new GitHub workflow template.

## 💡 Changes

* `framework.sh` now allows you to pass in `--dsyms/-d 1` to enable dSYM build.
* `validate_release.sh` now allows you to pass in `--swiftlint 0` to disable swiftlint.



## 1.0.1

This version updates `docc.sh` to support DocC hosted on a custom domain.

## 💡 Changes

* `docc.sh` now allows you to pass in a `--hosting-base-path`.



## 1.0

This version updates all `.github` and `scripts` scripts.

## ✨ Features

* `scripts` are rewritten from scratch with better argument parsing and --help support.
* `scripts` that need a target now use the package name as default target, if possible.

## 💡 Changes

* `.github` no longer pass in repository name as target, which makes them less brittle.

## 💥 Breaking changes

* `scripts` now use a different input argument format.
* `scripts` no longer contains package-specific scripts.



## 0.5

This version updates all `.github` and `scripts` scripts.

* `.github` scripts now use the latest versions of their dependencies.
* `scripts/build.sh` now asks for missing TARGET and uses `--p` or `--platforms` for PLATFORMS input.



## 0.4.3

This version makes `version_validate` scripts properly abort on error.

This version makes `test` automatically resolve any matching simulator.



## 0.4.2

This version improves `version_validate_git` to avoid false positives.



## 0.4.1

This version also adds a `sync_from.sh` script that can be run from any project.

The script will replace the script folder with one from a Swift Package Scripts folder.



## 0.4

This version adds three new scripts:

* `scripts/package_docc.sh` builds DocC for a Swift package.
* `scripts/package_framework.sh` builds an XCFramework for a Swift package.
* `scripts/package_version.sh` generates a git version tag for a Swift package.

This version also adds a `sync_to.sh` script that syncs `scripts` to another folder.

This version also renames `version_validate_project.sh` to `version_validate_target.sh`.



## 0.3.1

This version adds a `--no-semver` argument to the `version_bump` script.


## 0.3

This version adds three new scripts:

* `scripts/chmod.sh` makes all scripts in the script folder executable.
* `scripts/git_default_branch.sh` resolves the default git branch name.
* `scripts/package_name.sh` resolves the name of the main Swift package.


## 0.2.1

This patch fixes a redirect injection bug in the DocC script.


## 0.2

This version optimizes the scripts and reduces the number of sub-scripts.

* `script/build.sh` now supports providing a list of platforms to build.
* `script/build.sh` now runs `xcodebuild` instead of calling a script.
* `script/build_platform.sh` is no longer needed and has been removed.
* `script/docc.sh` now supports providing a list of platforms to build.
* `script/framework.sh` is a new script that builds an XCFramework for all provided platforms.
* `script/test.sh` now supports providing a list of platforms to test.
* `script/test.sh` now runs `xcodebuild` instead of calling a script.
* `script/test_platform.sh` is no longer needed and has been removed.
* `script/version_create.sh` has been renamed to `script/version.sh`.
* `script/version.sh` now supports providing a list of platforms to validate.
* `script/version_number_bump.sh` has been renamed to `script/version_bump.sh`.
* `script/version_validate_project.sh` now properly aborts when SwiftLint fails.


## 0.1.1

This patch updates the `version_create` root script to allow passing in a custom branch.


## 0.1

This is the first beta version of this library.

### 🧾 Scripts

* `scripts/build.sh` - Run builds for all supported platforms.
* `scripts/build_platform.sh` - Run builds for a certain platform.
* `scripts/docc.sh` - Build DocC documentation for GitHub Pages.
* `scripts/test.sh` - Run tests for all supported platforms.
* `scripts/test_platform.sh` - Run tests for a certain platform.
* `scripts/version_number.sh` - Get the current git version number.
* `scripts/version_number_bump.sh` - Bump and commit a new version number.
* `scripts/version_create.sh` - Create a new version.
* `scripts/version_validate_git.sh` - Validate that the repo is ready for release.
* `scripts/version_validate_project.sh` - Validate that the project is ready for release.

The `scripts/version_create.sh` script creates a new version with all required validation, build, and test steps.

There is also a root `version_create.sh` that calls the generic script for this package.
