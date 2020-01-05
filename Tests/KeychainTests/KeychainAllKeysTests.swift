//
//  KeychainAllKeysTests.swift
//  Keychain
//
//  Created by Rauhul Varma on 4/9/17.
//  Copyright © 2020 rauhul. All rights reserved.
//

import XCTest
@testable import Keychain

class KeychainAllKeysTests: XCTestCase {
    let testKey     = "testKey"
    let testValue   = "testValue"
    let testKey2    = "testKey2"
    let testValue2  = 1

    func testKeysEmpty() {
        XCTAssertEqual(Keychain.default.allKeys(), [], "Empty keychain should not contain keys")
    }
    
    func testKeysOneKey() {
        XCTAssertTrue(Keychain.default.store(testValue, forKey: testKey))
        
        XCTAssertEqual(Keychain.default.allKeys(), [testKey], "Keychain should contain the inserted key")
        
        XCTAssertTrue(Keychain.default.removeObject(forKey: testKey))
    }
    
    func testKeysMultipleKeys() {
        XCTAssertTrue(Keychain.default.store(testValue,  forKey: testKey))
        XCTAssertTrue(Keychain.default.store(testValue2, forKey: testKey2))
        
        XCTAssertEqual(Keychain.default.allKeys(), [testKey, testKey2], "Keychain should contain the inserted keys")
        
        XCTAssertTrue(Keychain.default.removeObject(forKey: testKey))
        XCTAssertTrue(Keychain.default.removeObject(forKey: testKey2))
    }
}
