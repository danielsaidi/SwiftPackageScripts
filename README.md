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

This repository contains scripts that let you easily build and test your Swift Package, and generate new versions for it.

These scripts replaces Fastlane for the most common tasks, to let you manage your entire CI/CD process without having to rely on Fastlane and Ruby. 

The repository also contains a `docc` script generates DocC documentation and prepare it for GitHub Pages. You can call it from your `.github/workflow` workflows to automatically publish documentation on each push.


## Scripts

The repository contains the following utility scripts:

* `scripts/build.sh` - Run builds for all provided platforms.
* `scripts/docc.sh` - Build DocC documentation for all provided platforms.
* `scripts/test.sh` - Run the project unit tests for all provided platforms.
* `scripts/version.sh` - Create a new version with validation and test steps.
* `scripts/version_bump.sh` - Bump the version number and push a new version tag.
* `scripts/version_number.sh` - Get the current git version number.
* `scripts/version_validate_git.sh` - Validate that the repo is ready for release.
* `scripts/version_validate_project.sh` - Validate that the project is ready for release.

Note that you may have to run `chmod +x <SCRIPT>` to be able to run a script.


## Project-pecific scripts

You can create project-specific scripts that call these scripts in pre-configured ways, for instance:

```bash
TARGET="SwiftPackageScripts"
PLATFORMS="iOS macOS tvOS watchOS xrOS"
BRANCH=${1:-"main"}
SCRIPT="scripts/version.sh"
chmod +x $SCRIPT
bash $SCRIPT $TARGET $BRANCH $PLATFORMS
```

You can have a look the root `version.sh` for reference, and create similar files for your own project.


## How to run these scripts

You can run the various build script like this:

```bash
./scripts/build.sh TARGET [PLATFORMS default: iOS macOS tvOS watchOS xrOS]
./scripts/docc.sh TARGET [PLATFORMS]
./scripts/test.sh TARGET [PLATFORMS]
```

To create a new version of your package, just run this from the project root:

```bash
./scripts/version_create.sh TARGET MAIN_BRANCH [PLATFORMS default: iOS macOS tvOS watchOS xrOS]
```

Note that `chmod +x` is required to use `./`, otherwise you have to use `bash ...`.


## Sample Package

This repository has a sample package that is used to test that everything works as expected.


## Documentation

You can find the generated, GitHub hosted documentation [here][Documentation].


[Documentation]: https://danielsaidi.github.io/SwiftPackageScripts/
