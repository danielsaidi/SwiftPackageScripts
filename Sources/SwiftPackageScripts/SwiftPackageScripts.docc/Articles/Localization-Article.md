# Localization Support

SwiftPackageScripts has an `l10n-gen` script that can generate public, namespaced key wrappers from any Xcode 26 string catalog.


## Why is this needed?

Xcode 26 can automatically generate explicit IDs for strings that you manually add to a string catalog. Using these IDs gives you type-safety, where removing a used key results in a compile-time error instead of broken localizations. 

The key identifiers that Xcode 26 auto-generates are however internal, which means that they can't be accessed from other packages or targets. The `scripts/l10n-gen` script can therefore generate public key wrappers for these internal keys.


## Running the script

The `scripts/l10n-gen` script can be called with the `--from/--to` or `--package/--catalog/--target` options. Use from and to to use any call-site relative paths, and the package approach to use a catalog and target file within a certain package.

```bash
./scripts/l10n-gen \
    --from Sources/MyPackage/Resources/Localizable.xcstrings \
    --to Sources/MyPackage/_Generated/Localizable.swift

# or
./scripts/l10n-gen \
    --package Sources/MyPackage \
    --catalog Resources/Localizable.xcstrings \
    --target _Generated/Localizable.swift
```

Have a look at the `l10n-gen` file in the project root to see how you can add a shortcut script for your own package. 


## Namespaces

The `scripts/l10n-gen` script will create a new namespace for each period you add to your keys, and will by default use `l10n` as the root namespace. 

This means that an `Onboarding.Title` key will by default be generated as `l10n.onboarding.title`.

You can use the `--root` parameter to customize the root namespace:

```bash
./scripts/l10n-gen --from ... --to ... --root myPackage
```

This would cause the `Onboarding.Title` to be generated as `.myPackage.onboarding.title` instead.


## Using the generated keys

Once generated, the public keys can be used wherever a `LocalizedStringResource` is expected:

```swift
import MyPackage
...
Text(.l10n.onboardings.app.title)
Text(.myPackage.onboardings.welcome.title)
```

The generated keys will by default use the `.module` bundle of the source string catalog, so you don't have to worry about having to specify the bundle when you use these public keys.
