# RELEASE NOTES


## 0.1

This is the first beta version of this library, with the following scripts.

### 🧾 Scripts

* `scripts/build.sh` - Build a TARGET for all supported platforms
* `scripts/build_platform.sh` - Build a TARGET for a certain PLATFORM
* `scripts/docc.sh` - Build DocC documentation and prepare it for GitHub Pages
* `scripts/test.sh` - Test a TARGET for all supported platforms
* `scripts/test_platform.sh` - Test a TARGET for a certain PLATFORM
* `scripts/validate_git.sh` - Validate that git is ready for release for a certain BRANCH
* `scripts/validate_project.sh` - Validate that the project is ready for release
* `scripts/version.sh` - Get the latest semver version
* `scripts/version_bump.sh` - Bump and commit a new version number
* `scripts/version_create.sh` - Create a new version for a certain TARGET and BRANCH

The `scripts/version_create.sh` script creates a new version with all required validation, build, and test steps.

You can create a project-specific version script in your project root, that calls `version_create` with your project-specific target and branch. Have a look at the `version_create.sh` file in the repository root for an example.