//
//  KeychainStorable.swift
//  Keychain
//
//  Created by Rauhul Varma on 3/3/17.
//  Copyright © 2017 rvarma. All rights reserved.
//

import Foundation

/// KeychainStorable defines a protocol a type must satisfy in order to be used in a Keychain operation; ie Stored, Retrieved, etc...
public protocol KeychainStorable {
    /// Converts a KeychainStorable Type into Data to be stored in the Keychain
    func keychainRepresentation() -> Data?
    
    /// Converts Data retrieved from the Keychain into a KeychainStorable Type
    init?(keychainRepresentation: Data)
}

/// Extend Bool to be KeychainStorable
extension Bool: KeychainStorable {
    /**
        Converts a Bool into Data to be stored in the Keychain
     */
    public func keychainRepresentation() -> Data? {
        return NSKeyedArchiver.archivedData(withRootObject: NSNumber(value: self))
    }
    
    /**
        Converts Data retrieved from the Keychain into a Bool
     */
    public init?(keychainRepresentation: Data) {
        guard let number = NSKeyedUnarchiver.unarchiveObject(with: keychainRepresentation) as? NSNumber else { return nil }
        self = number.boolValue
    }
}

/// Extend Int to be KeychainStorable
extension Int: KeychainStorable {
    public func keychainRepresentation() -> Data? {
        return NSKeyedArchiver.archivedData(withRootObject: NSNumber(value: self))
    }
    public init?(keychainRepresentation: Data) {
        guard let number = NSKeyedUnarchiver.unarchiveObject(with: keychainRepresentation) as? NSNumber else { return nil }
        self = number.intValue
    }
}

/// Extend Float to be KeychainStorable
extension Float: KeychainStorable {
    public func keychainRepresentation() -> Data? {
        return NSKeyedArchiver.archivedData(withRootObject: NSNumber(value: self))
    }
    public init?(keychainRepresentation: Data) {
        guard let number = NSKeyedUnarchiver.unarchiveObject(with: keychainRepresentation) as? NSNumber else { return nil }
        self = number.floatValue
    }
}

/// Extend Double to be KeychainStorable
extension Double: KeychainStorable {
    public func keychainRepresentation() -> Data? {
        return NSKeyedArchiver.archivedData(withRootObject: NSNumber(value: self))
    }
    public init?(keychainRepresentation: Data) {
        guard let number = NSKeyedUnarchiver.unarchiveObject(with: keychainRepresentation) as? NSNumber else { return nil }
        self = number.doubleValue
    }
}

/// Extend Data to be KeychainStorable
extension Data: KeychainStorable {
    public func keychainRepresentation() -> Data? {
        return self
    }
    public init?(keychainRepresentation: Data) {
        self = keychainRepresentation
    }
}


/// Extend String to be KeychainStorable
extension String: KeychainStorable {
    public func keychainRepresentation() -> Data? {
        return data(using: .utf8)
    }
    public init?(keychainRepresentation: Data) {
        guard let string = String(data: keychainRepresentation, encoding: String.Encoding.utf8) else {
            return nil
        }
        self = string
    }
}


// FIXME: Make NSCoding KeychainStorable
/*
/// Extend NSCoding to be KeychainStorable
extension KeychainStorable where Self: NSCoding {
    /// Converts an object conforming to NSCoding into Data to be stored in the Keychain
    func keychainRepresentation() -> Data? {
        return NSKeyedArchiver.archivedData(withRootObject: self)
    }
    
    /// Converts Data retrieved from the Keychain into a NSCoding Type
    init?(keychainRepresentation: Data) {
        guard let object = NSKeyedUnarchiver.unarchiveObject(with: keychainRepresentation) as? NSCoding else {
            return nil
        }
        
        self = object
    }

}
 */

