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
* `package_name.sh` - Get the name of the main Swift package.
* `test.sh` - Run the project unit tests for all provided platforms.
* `version.sh` - Create a new version with validation and test steps.
* `version_bump.sh` - Bump the version number and push a new version tag.
* `version_number.sh` - Get the current git version number.
* `version_validate_git.sh` - Validate that the repo is ready for release.
* `version_validate_project.sh` - Validate that the project is ready for release.

Note that you may have to run `chmod +x <SCRIPT>` to be able to run a script.


## Project-pecific scripts

You can create project-specific scripts that call these scripts in pre-configured ways, for instance:

```bash
# package_version.sh

TARGET="SwiftPackageScripts"
PLATFORMS="iOS macOS tvOS watchOS xrOS"
BRANCH=${1:-"main"}
SCRIPT="scripts/version.sh"
chmod +x $SCRIPT
bash $SCRIPT $TARGET $BRANCH $PLATFORMS
```

You can have a look the root `version.sh` for reference, and create similar files for your own project.


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
