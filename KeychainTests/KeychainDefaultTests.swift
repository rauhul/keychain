//
//  KeychainDefaultWrapperTests.swift
//  SwiftKeychain
//
//  Created by Jason Rendel on 8/8/16.
//  Copyright © 2016 Jason Rendel. All rights reserved.
//

import XCTest
@testable import Keychain

class KeychainDefaultWrapperTests: XCTestCase {
    let testKey = "acessorTestKey"
    let testString = "This is a test"
    
    let testKey2 = "acessorTestKey2"
    let testString2 = "Test 2 String"
    
    override func setUp() {
        super.setUp()
        // Put storeup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        // clean up keychain
        Keychain.default.removeObject(forKey: testKey)
        Keychain.default.removeObject(forKey: testKey2)
        
        super.tearDown()
    }
    
    func testDefaultServiceName() {
        let bundleIdentifier = Bundle.main.bundleIdentifier
        if let bundleIdentifierString = bundleIdentifier {
            XCTAssertEqual(Keychain.default.serviceName, bundleIdentifierString, "Service Name should be equal to the bundle identifier when it is accessible")
        } else {
            XCTAssertEqual(Keychain.default.serviceName, "SwiftKeychain", "Service Name should be equal to SwiftKeychain when the bundle identifier is not accessible")
        }
    }
    
    func testDefaultAccessGroup() {
        XCTAssertNil(Keychain.default.accessGroup, "Access Group should be nil when nothing is store")
    }
    
    func testHasValueForKey() {
        XCTAssertFalse(Keychain.default.hasValue(forKey: testKey), "Keychain should not have a value for the test key")
        
        Keychain.default.store(testString, forKey: testKey)

        XCTAssertTrue(Keychain.default.hasValue(forKey: testKey), "Keychain should have a value for the test key after it is store")
    }
    
    func testRemoveObjectFromKeychain() {
        Keychain.default.store(testString, forKey: testKey)
        
        XCTAssertTrue(Keychain.default.hasValue(forKey: testKey), "Keychain should have a value for the test key after it is store")
        
        Keychain.default.removeObject(forKey: testKey)
        
        XCTAssertFalse(Keychain.default.hasValue(forKey: testKey), "Keychain should not have a value for the test key after it is removed")
    }
    
    func testStringSave() {
        let stringSaved = Keychain.default.store(testString, forKey: testKey)
        
        XCTAssertTrue(stringSaved, "String did not save to Keychain")
        
        // clean up keychain
        Keychain.default.removeObject(forKey: testKey)
    }
    
    func testUpdateAccessibility() {
        let stringSaved = Keychain.default.store(testString, forKey: testKey)
        
        XCTAssertTrue(stringSaved, "String did not save to Keychain")
        
        let stringUpdated = Keychain.default.store("updateString", forKey: testKey)
        
        XCTAssertTrue(stringUpdated, "String did not update Keychain")

        // clean up keychain
        Keychain.default.removeObject(forKey: testKey)
    }

    
    
    func testStringRetrieval() {
        Keychain.default.store(testString, forKey: testKey)
        
        if let retrievedString = Keychain.default.retrieve(String.self ,forKey: testKey) {
            XCTAssertEqual(retrievedString, testString, "String retrieved for key should equal string saved for key")
        } else {
            XCTFail("String for Key not found")
        }
    }
    
    func testStringRetrievalWhenValueDoesNotExist() {
        let retrievedString = Keychain.default.retrieve(String.self ,forKey: testKey)
        XCTAssertNil(retrievedString, "String for Key should not exist")
    }
    
    func testMultipleStringSave() {
        if !Keychain.default.store(testString, forKey: testKey) {
            XCTFail("String for testKey did not save")
        }
        
        if !Keychain.default.store(testString2, forKey: testKey2) {
            XCTFail("String for testKey2 did not save")
        }
        
        if let string1Retrieved = Keychain.default.retrieve(String.self ,forKey: testKey) {
            XCTAssertEqual(string1Retrieved, testString, "String retrieved for testKey should match string saved to testKey")
        } else {
            XCTFail("String for testKey could not be retrieved")
        }
        
        if let string2Retrieved = Keychain.default.retrieve(String.self ,forKey: testKey2) {
            XCTAssertEqual(string2Retrieved, testString2, "String retrieved for testKey2 should match string saved to testKey2")
        } else {
            XCTFail("String for testKey2 could not be retrieved")
        }
    }
    
    func testMultipleStringsSavedToSameKey() {
        
        if !Keychain.default.store(testString, forKey: testKey) {
            XCTFail("String for testKey did not save")
        }
        
        if let string1Retrieved = Keychain.default.retrieve(String.self, forKey: testKey) {
            XCTAssertEqual(string1Retrieved, testString, "String retrieved for testKey after first save should match first string saved testKey")
        } else {
            XCTFail("String for testKey could not be retrieved")
        }
        
        if !Keychain.default.store(testString2, forKey: testKey) {
            XCTFail("String for testKey did not update")
        }
        
        if let string2Retrieved = Keychain.default.retrieve(String.self ,forKey: testKey) {
            XCTAssertEqual(string2Retrieved, testString2, "String retrieved for testKey after update should match second string saved to testKey")
        } else {
            XCTFail("String for testKey could not be retrieved after update")
        }
    }
    
    func testDataSave() {
        let testData = testString.data(using: String.Encoding.utf8)
        
        if let data = testData {
            let dataSaved = Keychain.default.store(data, forKey: testKey)
            
            XCTAssertTrue(dataSaved, "Data did not save to Keychain")
        } else {
            XCTFail("Failed to create Data")
        }
    }
    
    func testDataRetrieval() {
        guard let testData = testString.data(using: String.Encoding.utf8) else {
            XCTFail("Failed to create Data")
            return
        }
        
        Keychain.default.store(testData, forKey: testKey)
        
        guard let retrievedData = Keychain.default.retrieve(Data.self, forKey: testKey) else {
            XCTFail("Data for Key not found")
            return
        }
        
        if Keychain.default.retrieve(Data.self, forKey: testKey, asReference: true) == nil {
            XCTFail("Data references for Key not found")
        }
        
        if let retrievedString = String(data: retrievedData, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue)) {
            XCTAssertEqual(retrievedString, testString, "String retrieved from data for key should equal string saved as data for key")
        } else {
            XCTFail("Output Data for key does not match input. ")
        }
    }
    
    func testDataRetrievalWhenValueDoesNotExist() {
        let retrievedData = Keychain.default.retrieve(Data.self, forKey: testKey)
        XCTAssertNil(retrievedData, "Data for Key should not exist")
        
        let retrievedDataRef = Keychain.default.retrieve(Data.self, forKey: testKey, asReference: true)
        XCTAssertNil(retrievedDataRef, "Data ref for Key should not exist")
    }
}
