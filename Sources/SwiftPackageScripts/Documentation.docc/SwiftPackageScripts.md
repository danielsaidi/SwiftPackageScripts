# ``SwiftPackageScripts``

## Overview

![SwiftPackageScripts logotype](Logo.png)

This repository contains Swift Package scripts that let you easily build and test your Swift Package, and generate new versions for it with a flexible `version_create` script.

These scripts replaces Fastlane for the most common tasks, to let you manage your entire CI/CD process without having to rely on Fastlane and Ruby. 

The repository also contains a `docc` script generates DocC documentation and prepare it for GitHub Pages. You can call it from your `.github/workflow` workflows to automatically publish documentation on each push.


## Scripts

The repository contains the following utility scripts:

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
