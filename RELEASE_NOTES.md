# RELEASE NOTES

[Swift Package Scripts](https://github.com/danielsaidi/SwiftPackageScripts) honors semantic versioning, with the following strategy:

* Deprecations can happen at any time.
* Deprecations are removed in `major` updates.
* Breaking changes should only occur in `major` updates.
* Breaking changes *can* occur in `minor` and `patch` updates, if the alternative is worse.

Beta version tags and releases are removed after the next minor or major version. 



## 3.0.1

## 🐛 Bug Fixes

* `scripts/sync-from` used the wrong `--ghw` arg instead of `-ghw`.



## 3.0

This version removes the `.sh` extension from all `scripts/` files.

This lets us run them like `./scripts/build --help` instead of `./scripts/build.sh --help`.

This version also updates all GitHub workflows to run the scripts without extension. 



## 2.1.1

This version makes it possible to run the `xcframework` workflow for specific platforms.

## ✨ Features

* `.github/workflows/xcframework.yml` now defines a platform picker.



## 2.1

This version adds new scripts and multiplatform DocC support.

The new `docc-multiplatform` workflow is currently manual, until it's verified that it works well. After that, it should be merged with the `docc` workflow.

## ✨ Features

* `scripts/docc-multiplatform.sh` is a new script for building multiplatform DocC.
* `scripts/package-platforms.sh` is a new script for getting all supported platforms for the main Swift package.

## 💡 Changes

* `.github/workflows/docc.yml` now supports picking a specific platform or "multiplatform".
* `.github/workflows/docc-multiplatform.yml` is a new, manual workflow for deploying multiplatform DocC documentation to GitHub pages.



## 2.0.2

### 💡 Changes

* `scripts/git-default-branch-name.sh` now supports a fallback result.

### 🐛 Bug Fixes

* `github/workflows/xcframework.sh` had an old script name reference.



## 2.0.1

This version makes `StringCatalogKeyBuilder` tool independent of `SwiftPackageScripts`. This solves a bug where it would crash in other package folders.

This version also fixes a bug where trying to use the CLI to write to a non-existing folder would not work, by upgrading both the `l10n-gen` script and the CLI tool.

## 💡 Changes

* The `StringCatalogKeyBuilder` CLI tool now builds on all platforms.

## 🐛 Bug Fixes

* `scripts/l10n-gen` no longer fails if the target folder doesn't exist.
* `tools/StringCatalogKeyBuilder` no longer needs the main package to function.
* `tools/StringCatalogKeyBuilder` no longer fails if the target folder doesn't exist.



## 2.0

This version renames several scripts to use dashes instead of underline.

This version adds tools for generating public localization keys for a string catalog. This makes it possible to use a package's internal localization keys from other targets.

This version also adds a CLI tool called `StringCatalogKeyBuilder` and a script called `l10n-gen.sh`, which can generate a public localization key swift file for any package. 

## ✨ Features

* `StringCatalog` is a new struct that can parse Xcode string catalogs.
* `scripts/l10n-gen.sh` is a new Terminal script for parsing string catalogs.
* `scripts/sync-to.sh` and `scripts/sync-from.sh` can now sync `.github/workflows` too.
* `scripts/tools/StringCatalogKeyBuilder` is a new CLI tool for parsing string catalogs.

## 💡 Changes

* Many scripts has been refactored to be more optimal.
* All workflows now target the latest macOS and Xcode.

* `release.sh` now calls `release-validate-git.sh`.
* `release-validate-git.sh` now uses `git-default-branch.sh`.
* `release-validate-package.sh` no longer calls `release-validate-git.sh`.

## 💥 Breaking changes

Due to the localized string key support, the package now targets iOS 16.

* `.github/workflows/binary_artifacts.yml` has been renamed to `xcframework.yml`.
* `.github/workflows/version_bump.yml` has been renamed to `version-bump.yml`.
* `scripts/chmod.sh` has been renamed to `chmod-all.sh`.
* `scripts/git_default_branch.sh` has been renamed to `git-default-branch.sh`.
* `scripts/release.sh` now requires `--branch|-b` to pass in a branch.
* `scripts/release-validate-git.sh` now requires `--branch|-b` to pass in a branch.
* `scripts/sync_from.sh` has been renamed to `sync-from.sh`. 
* `sync_to.sh` has been moved to `scripts` and is renamed to `sync-to.sh`. 
* `scripts/validate_git_branch.sh` has been renamed to `release-validate-git.sh`.
* `scripts/validate_release.sh` has been renamed to `release-validate-package.sh`.
* `scripts/version_bump.sh` has been renamed to `version-bump.sh`. 
* `scripts/version_number.sh` has been renamed to `version-number.sh`. 



## 1.3

This version adds a new tools folder with Swift command line tools.



## 1.2.2

This version updates all GitHub workflows to cancel all other in-progress runners of the same type.



## 1.2.1

This version makes `binary_artifacts.yml` name the container zip differently.



## 1.2

This version adds a  updates `binary_artifacts.yml` to upload unzipped files.

The binary artifact workflow has been adjusted to upload a container zip file, to avoid data loss.

## ✨ Features

* `version_bump.yml` is a new GitHub Actions workflow.
* `version_bump.sh` has new `--type` and `--version` parameters.

## 💡 Changes

* `xcframework-binaries.yml` is renamed to `binary_artifacts.yml`.
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
