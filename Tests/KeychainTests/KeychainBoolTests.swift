//
//  KeychainBoolTests.swift
//  Keychain
//
//  Created by Rauhul Varma on 4/9/17.
//  Copyright © 2020 rauhul. All rights reserved.
//

import XCTest
@testable import Keychain

class KeychainBoolTests: XCTestCase {
    let testKey = "testKey"
    let testValue: Bool = true
    
    func testStore() {
        XCTAssertTrue(Keychain.default.store(testValue, forKey: testKey), "Value did not save to Keychain")
        XCTAssertTrue(Keychain.default.removeObject(forKey: testKey))
    }
    
    func testRetrieve() {
        XCTAssertTrue(Keychain.default.store(testValue, forKey: testKey))
        
        if let retrievedValue = Keychain.default.retrieve(Bool.self, forKey: testKey) {
            XCTAssertEqual(retrievedValue, testValue, "Value retrieved for key should equal value saved for key")
        } else {
            XCTFail("Value for key not found")
        }
    }
    
    func testDelete() {
        XCTAssertTrue(Keychain.default.store(testValue, forKey: testKey), "Value did not save")
        XCTAssertTrue(Keychain.default.removeObject(forKey: testKey), "Value was not removed")
        XCTAssertNil( Keychain.default.retrieve(Bool.self, forKey: testKey), "No value should exist for key")
    }
}
