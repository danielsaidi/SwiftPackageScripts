# ``SwiftPackageBuildScripts``

This repository contains Swift Package Build Scripts that let you easily build and test your package, and generate new versions for it with a flexible `version_create` script.

These scripts replaces Fastlane for the most common tasks, to let you manage your entire CI/CD process without having to rely on Fastlane and Ruby. 

The repository also contains a `docc` script generates DocC documentation and prepare it for GitHub Pages. You can call it from your `.github/workflow` workflows to automatically publish documentation on each push.


## Scripts

The repository contains the following utility scripts:

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


## How to call a script from the project root

To create a new version of your Swift Package, you only have to run this from the project root:

```bash
bash scripts/version_create.sh ProjectName MainBranch
```

To avoid having to type the project name and main branch every time, you can create a project-specific version script in your project root, that calls `version_create` with your project-specific target and branch.

Have a look at the `version_create.sh` file in the repository root for an example.

With such a file in place, you only have to run:

```bash
bash version_create.sh
```

If the file sets up `chmod +x` for itself, you then only have to type this:

```bash
./version_create.sh
```

This makes building, testing and releasing your Swift Package a whoe lot easier, and removes the need of depending on Fastlane and Ruby.
