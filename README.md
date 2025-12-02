<p align="center">
    <img src="Resources/Icon.png" alt="Project Icon" width="250" />
</p>

<p align="center">
    <img src="https://img.shields.io/github/v/release/danielsaidi/SwiftPackageScripts?color=%2300550&sort=semver" alt="Version" title="Version" />
    <img src="https://img.shields.io/badge/swift-6.0-orange.svg" alt="Swift 6.1" title="Swift 6.0" />
    <a href="https://danielsaidi.github.io/SwiftPackageScripts"><img src="https://img.shields.io/badge/documentation-web-blue.svg" alt="Documentation" /></a>
    <a href="https://github.com/danielsaidi/SwiftPackageScripts/blob/master/LICENSE"><img src="https://img.shields.io/github/license/danielsaidi/SwiftPackageScripts" alt="MIT License" /></a>
</p>


# Swift Package Scripts

Swift Package Scripts has Terminal scripts that can be used to build and test your package, build DocC and deploy it to GitHub Pages, generate XCFramework binary artifacts, create new semantic versions, etc.

Swift Package Scripts also has a collection of GitHub Actions workflows that can run some scripts from the GitHub Actions dashboard.


## Installation

Swift Package Scripts can be installed to your computer by cloning the repository:

```
git clone https://github.com/danielsaidi/SwiftPackageScripts.git
```

You can then navigate to the folder and sync the scripts to any older folder, using the `/sync-to.sh` script.

```shell
./sync-to.sh ../AnotherPackage [--github-workflows 1]
```

This will replace any existing scripts with the latest versions. After this, you can use `scripts/sync-from.sh` in that project folder.


## Scripts

The `scripts` folder contains Swift Package-related scripts, that can all be customized with their own parameters:

* `build.sh` - Build a target for all or some platforms.
* `chmod-all.sh` - Runs `chmod +x` on all scripts in the script folder.
* `docc.sh` - Build DocC documentation for all or some platforms.
* `git-default-branch.sh` - Get the default git branch name.
* `l10n-gen.sh` - Generate public translation key wrappers from an Xcode 26 string catalog.
* `package-name.sh` - Get the name of the main Swift package.
* `release.sh` - Make a release build with several validation steps.
* `release-validate-git.sh` - Validate the git repo for release.
* `release-validate-package.sh` - Validate the package for release.
* `sync-from.sh` - Sync `scripts` and `.github/workflows` from a Swift Package Scripts folder.
* `sync-to.sh` - Sync `scripts` and `.github/workflows` to another package folder.
* `test.sh` - Test a target on all or some platforms.
* `version-bump.sh` - Bump the current version number and create a new tag.
* `version-number.sh` - Get the current version number from the latest tag.
* `xcframework.sh` - Build an XCFramework for all or some platforms.

All scripts have a `--help` command, e.g. `./scripts/build.sh --help`. Note that you have to run `chmod +x <SCRIPT>` to be able to run a script for the first time.


## GitHub Action Workflows

The `.github` folder contains the following GitHub Actions workflows:

* `build.yml` - Build the package for all or some platforms.
* `docc.yml` - Build DocC documentation and deploy it to GitHub Pages.
* `test.yml` - Test the package on all or some platforms.
* `version_bump.yml` - Bump the current version number and create a new tag.
* `xcframework.yml` - Build an XCFramework and dSYMs for all or some platforms.

Have a look at each file for workflow-specific information and if there is anything you need to do to make it work.


## String Catalog Support

SwiftPackageScripts has an `l10n-gen.sh` script that can generate public, namespaced key wrappers from any Xcode string catalog.

Once generated, these public keys can be used from any package and app, wherever a `LocalizedStringResource` is expected:

```swift
Text(.l10n.myapp.onboardings.welcome.title)
```

You can read more about this in the [localization][Localization] article.


## Sample Package

This repository has a sample package that is used to test that everything works as expected.


## Documentation

For more information about these scripts, and how to set up project-specific scripts, see the online [here][Documentation].


## Support My Work

You can [become a sponsor][Sponsors] to help me dedicate more time on my various [open-source tools][OpenSource]. Every contribution, no matter the size, makes a real difference in keeping these tools free and actively developed.


## Contact

Feel free to reach out if you have questions or if you want to contribute in any way:

* Website: [danielsaidi.com][Website]
* Mastodon: [@danielsaidi@mastodon.social][Mastodon]
* Twitter: [@danielsaidi][Twitter]
* E-mail: [daniel.saidi@gmail.com][Email]


## License

Swift Package Scripts is available under the MIT license. See the [LICENSE][License] file for more info.


[Email]: mailto:daniel.saidi@gmail.com
[Website]: https://www.danielsaidi.com
[GitHub]: https://www.github.com/danielsaidi
[Twitter]: https://www.twitter.com/danielsaidi
[Mastodon]: https://mastodon.social/@danielsaidi
[Sponsors]: https://github.com/sponsors/danielsaidi
[OpenSource]: https://www.danielsaidi.com/opensource

[Documentation]: https://danielsaidi.github.io/swiftpackagescripts/
[Localization]: https://danielsaidi.github.io/swiftpackagescripts/documentation/swiftpackagescripts/localization-article
[License]: https://github.com/danielsaidi/SystemNotification/blob/master/LICENSE
