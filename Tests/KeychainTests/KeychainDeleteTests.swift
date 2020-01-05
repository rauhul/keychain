//
//  KeychainDeleteTests.swift
//  SwiftKeychain
//
//  Created by Jason Rendel on 3/25/16.
//  Copyright © 2016 Jason Rendel. All rights reserved.
//

import XCTest
@testable import Keychain

class KeychainDeleteTests: XCTestCase {
    let testKey = "testKey"
    let testString = "This is a test"

    func testRemoveAllKeysDeletesSpecificKey() {
        // save a value we can test delete on
        XCTAssertTrue(Keychain.default.store(testString, forKey: testKey), "String did not save to Keychain")
        
        // delete all
        let removeSuccessful = Keychain.default.purge()
        
        XCTAssertTrue(removeSuccessful, "Failed to remove all Keys")
        
        // confirm our test value was deleted
        let retrievedValue = Keychain.default.retrieve(String.self ,forKey: testKey)
        
        XCTAssertNil(retrievedValue, "Test value was not deleted")
    }
}
