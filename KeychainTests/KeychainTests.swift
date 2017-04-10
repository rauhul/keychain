//
//  KeychainTests.swift
//  SwiftKeychain
//
//  Created by Jason Rendel on 4/25/16.
//  Copyright © 2016 Jason Rendel. All rights reserved.
//

import XCTest
@testable import Keychain

class KeychainTests: XCTestCase {
    
    func testCustomInstance() {
        let uniqueServiceName = UUID().uuidString
        let uniqueAccessGroup = UUID().uuidString
        let customKeychainInstance = Keychain(serviceName: uniqueServiceName, accessGroup: uniqueAccessGroup)
        
        XCTAssertNotEqual(customKeychainInstance.serviceName, Keychain.default.serviceName, "Custom instance initialized with unique service name, should not match default Service Name")
        XCTAssertNotEqual(customKeychainInstance.accessGroup, Keychain.default.accessGroup, "Custom instance initialized with unique access group, should not match default Access Group")
    }
    
    func testAccessibility() {
        let accessibilityOptions = [
            Keychain.Accessibility.afterFirstUnlock,
            Keychain.Accessibility.afterFirstUnlockThisDeviceOnly,
            Keychain.Accessibility.always,
            Keychain.Accessibility.whenPasscodeSetThisDeviceOnly,
            Keychain.Accessibility.alwaysThisDeviceOnly,
            Keychain.Accessibility.whenUnlocked,
            Keychain.Accessibility.whenUnlockedThisDeviceOnly
        ]
        
        let key = "testKey"
        let value = "testValue"
        
        for accessibilityOption in accessibilityOptions {
            
            XCTAssertTrue(Keychain.default.store(value, forKey: key, withAccessibility: accessibilityOption))
            
            
            let testOption = accessibilityOption
            let retrievedOption = Keychain.default.accessibility(ofKey: key)
            
            if retrievedOption == nil {
                XCTAssertNotNil(retrievedOption)
            } else {
                XCTAssertEqual(retrievedOption!, testOption, "Accessibility does not match. Expected: \(retrievedOption!) Found: \(testOption)")
            }
            
            // INFO: If re-using a key but with a different accessibility, first remove the previous key value using removeObjectForKey(:withAccessibility) using the same accessibilty it was saved with
            let removeResult = Keychain.default.removeObject(forKey: key, withAccessibility: accessibilityOption)
            XCTAssertTrue(removeResult, "Unable to remove value")
        }
    }
}
