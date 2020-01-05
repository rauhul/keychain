# Keychain
[![Swift Version](https://img.shields.io/badge/swift-v5.0-orange.svg)](https://github.com/apple/swift)
[![Documentation Converage](https://raw.githubusercontent.com/rauhul/keychain/master/docs/badge.svg?sanitize=true)](https://rauhul.me/keychain/)
[![Release Version](https://img.shields.io/badge/release-v0.2.0-ff69b4.svg)](https://github.com/rauhul/keychain/releases)
[![GitHub License](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/rauhul/keychain/master/LICENSE)

A simple inteferace for using the iOS Keychain, written in Swift. Heavily based on the work done by Jason Rendel in [SwiftKeychainWrapper](https://github.com/jrendel/SwiftKeychainWrapper).

Provides singleton instance `Keychain.default` that is setup to work for most needs.

If you need to customize the keychain access to use a custom identifier or access group, you can create your own instance instead of using the provided singleton.

By default, the Keychain saves data as a Generic Password type in the iOS Keychain. It saves items such that they can only be accessed when the app is unlocked and open. If you are not familiar with the iOS Keychain usage, this provides a safe default for using the keycain.

Users that want to deviate from this default implementation can specifiy keychain accessibility for each request (store, retrieve, etc...) to a Keychain instance.

## Requirements
- Swift 5.0+

### Notes
Keychain 0.1.2 is the last version that supports cocoapods
Keychain 0.1.2 is the last release with Swift 4.2 support

## Installation

### Swift Package Manager
The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler.

Once you have your Swift package set up, adding Keychain as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
    .Package(url: "https://github.com/rauhul/keychain.git", from: "0.2.0")
]
```

To use the keychain in your app, import Keychain into the file(s) where you want to use it.

``` swift
import Keychain
```

## General Usage

Store a string value to keychain:

``` swift
let saveSuccessful = Keychain.default.store("exampleValue", forKey: "exampleKey")
```

Retrieve a string value from keychain:

``` swift
let retrievedString = Keychain.default.retrieve(String.self, forKey: "exampleKey")
```

Delete a string value from keychain:

``` swift
let removeSuccessful = Keychain.default.removeObject(forKey: "exampleKey")
```

## Custom Instance

When the Keychain Wrapper is used, all keys are linked to a common identifier for your app, called the service name. By default this uses your main bundle identifier. However, you may also change it, or store multiple items to the keycahin under different identifiers.

To share keychain items between your applications, you may specify an access group and use that same access group in each application.

To set a custom service name identifier or access group, you may create your own keychain instance as follows:

``` swift
let uniqueServiceName = "customServiceName"

let uniqueAccessGroup = "sharedAccessGroupName"

let customKeychainInstance = Keychain(serviceName: uniqueServiceName, accessGroup: uniqueAccessGroup)
```

The custom instance can then be used in place of the provided instance:

``` swift
let saveSuccessful = customKeychainInstance.store("exampleValue", forKey: "exampleKey")

let retrievedString = customKeychainInstance.retrieve(String.self, forKey: "exampleKey")

let removeSuccessful = customKeychainInstance.removeObject(forKey: "exampleKey")
```

## Accessibility Options

By default, all items saved to keychain can only be accessed when the device is unlocked. To change this accessibility, an optional "withAccessibility" param can be set on all requests. The enum Keychain.Accessibilty provides an easy way to select the accessibility level desired:

``` swift
Keychain.default.store(<KeychainStorable>, forKey: "exampleKey", withAccessibility: .afterFirstUnlock)
```
