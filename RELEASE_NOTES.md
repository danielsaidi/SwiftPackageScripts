# RELEASE NOTES


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
