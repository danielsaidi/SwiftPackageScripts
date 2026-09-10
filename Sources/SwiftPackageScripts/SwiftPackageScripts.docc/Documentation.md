# ``SwiftPackageScripts``

## Overview

![SwiftPackageScripts logotype](Logo.png)

Swift Package Scripts has Terminal scripts that can be used to build and test your package, build DocC and deploy it to GitHub Pages, generate XCFramework binary artifacts, create new semantic versions, etc.

Swift Package Scripts also has a collection of GitHub Actions workflows that can run some scripts from the GitHub Actions dashboard.


## Installation

Swift Package Scripts can be installed to your computer by cloning the repository:

```
git clone https://github.com/danielsaidi/SwiftPackageScripts.git
```

You can then navigate to the folder and sync the scripts to any older folder, using the `/sync-to` script.

```shell
./sync-to ../AnotherPackage [--github-workflows 1]
```

This will replace any existing scripts with the latest versions. After this, you can use `scripts/sync-from` in that project folder.


## Scripts

The `scripts` folder contains Swift Package-related scripts, that can all be customized with their own parameters:

* `build` - Build a target for any platforms.
* `chmod-all` - Runs `chmod +x` on all scripts in the script folder.
* `docc` - Build DocC documentation.
* `docc-multiplatform` - Build multi-platform DocC documentation.
* `git-default-branch` - Get the default git branch name.
* `l10n-gen` - Generate public translation key wrappers from an Xcode 26 string catalog.
* `package-name` - Get the name of the main Swift package.
* `package-platforms` - Get the supported platforms of the main Swift package.
* `release` - Make a release build with several validation steps.
* `release-validate-git` - Validate the git repo for release.
* `release-validate-package` - Validate the package for release.
* `sync-from` - Sync `scripts` and `.github/workflows` from a Swift Package Scripts folder.
* `sync-to` - Sync `scripts` and `.github/workflows` to another package folder.
* `test` - Test a target for any platforms.
* `version-bump` - Bump the current version number and create a new tag.
* `version-number` - Get the current version number from the latest tag.
* `xcframework-dynamic` - Build a dynamic XCFramework for any platforms.
* `xcframework-static` - Build a static XCFramework for any platforms.

All scripts have a `--help` command, e.g. `./scripts/build --help`. Note that you have to run `chmod +x <SCRIPT>` to be able to run a script for the first time.


## GitHub Actions

The `.github` folder contains the following GitHub Actions workflows:

* `build.yml` - Build the package for any platforms.
* `docc.yml` - Build DocC documentation and deploy it to GitHub Pages.
* `docc-multiplatform.yml` - Build multi-platform DocC documentation.
* `test.yml` - Test the package for any platforms.
* `version-bump.yml` - Bump the current version number and create a new tag.
* `xcframework-dynamic` - Build a dynamic XCFramework for any platforms.
* `xcframework-static` - Build a static XCFramework for any platforms.

Have a look at each file for workflow-specific information and if there is anything you need to do to make it work.


## String Catalog Support

SwiftPackageScripts has an `l10n-gen` script that can generate public, namespaced key wrappers from any Xcode string catalog.

Once generated, these public keys can be used from any package and app, wherever a `LocalizedStringResource` is expected:

```swift
Text(.l10n.myapp.onboardings.welcome.title)
```

You can read more about this in the <doc:Localization> article.


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


## Topics

### Articles

- <doc:Localization-Article>

### Types

- ``StringCatalog``


[Email]: mailto:daniel.saidi@gmail.com
[Website]: https://www.danielsaidi.com
[GitHub]: https://www.github.com/danielsaidi
[Twitter]: https://www.twitter.com/danielsaidi
[Mastodon]: https://mastodon.social/@danielsaidi
[Sponsors]: https://github.com/sponsors/danielsaidi
[OpenSource]: https://www.danielsaidi.com/opensource

[Documentation]: https://danielsaidi.github.io/SwiftPackageScripts/
[License]: https://github.com/danielsaidi/SystemNotification/blob/master/LICENSE
