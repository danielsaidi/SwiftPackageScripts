# RELEASE NOTES


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
