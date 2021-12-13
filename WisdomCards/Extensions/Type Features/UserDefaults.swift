//
//  UserDefaults.swift
//  WisdomCards
//
//  Created by NAVEEN MADHAN on 12/13/21.
//

import Foundation
import UIKit
import Combine
import SwiftUI

// MARK: USER DEFAULTS
extension UserDefaults: ObjectSavable {
    func setObject<Object>(_ object: Object, forKey: String) throws where Object: Encodable {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(object)
            set(data, forKey: forKey)
        } catch {
            throw ObjectSavableError.unableToEncode
        }
    }
    
    func getObject<Object>(forKey: String, castTo type: Object.Type) throws -> Object where Object: Decodable {
        guard let data = data(forKey: forKey) else { throw ObjectSavableError.noValue }
        let decoder = JSONDecoder()
        do {
            let object = try decoder.decode(type, from: data)
            return object
        } catch {
            throw ObjectSavableError.unableToDecode
        }
    }
    
    func fetch<T: Codable>(for type: T.Type, using key: String) -> T? {
        let defaults = UserDefaults.standard
        guard let data = defaults.object(forKey: key) as? Data else {return nil}
        let decodedObject = try? PropertyListDecoder().decode(type, from: data)
        return decodedObject
    }
    
    func feed<T: Codable>(for type: T, using key: String) {
        let defaults = UserDefaults.standard
        let encodedData = try? PropertyListEncoder().encode(type)
        defaults.set(encodedData, forKey: key)
    }
    
}

protocol ObjectSavable {
    func setObject<Object>(_ object: Object, forKey: String) throws where Object: Encodable
    func getObject<Object>(forKey: String, castTo type: Object.Type) throws -> Object where Object: Decodable
}

enum ObjectSavableError: String, LocalizedError {
    case unableToEncode = "Unable to encode object into data"
    case noValue = "No data object found for the given key"
    case unableToDecode = "Unable to decode object into given type"
    
    var errorDescription: String? {
        rawValue
    }
}

extension AnyPublisher {
    
    static func error<T, E>(_ error: E) -> AnyPublisher<T, E> {
        return Future<T, E> { $0(.failure(error)) }.eraseToAnyPublisher()
    }
}

enum CombineError: Error {
    case released
}


extension MutableCollection where Self : RandomAccessCollection {
    
    // Mutating in-place sort:
    mutating func sort<T: Comparable>(byKeyPath keyPath: KeyPath<Element, T>) {
        sort(by: { $0[keyPath: keyPath] < $1[keyPath: keyPath] })
    }
    
    mutating func sort(
        by firstPredicate: (Element, Element) -> Bool,
        _ secondPredicate: (Element, Element) -> Bool,
        _ otherPredicates: ((Element, Element) -> Bool)...
    ) {
        sort(by:) { lhs, rhs in
            if firstPredicate(lhs, rhs) { return true }
            if firstPredicate(rhs, lhs) { return false }
            if secondPredicate(lhs, rhs) { return true }
            if secondPredicate(rhs, lhs) { return false }
            for predicate in otherPredicates {
                if predicate(lhs, rhs) { return true }
                if predicate(rhs, lhs) { return false }
            }
            return false
        }
    }
    
}


extension Sequence {
    
    
    // Non-mutating sort, returning a new array:
    func sorted<T: Comparable>(byKeyPath keyPath: KeyPath<Element, T>) -> [Element] {
        return sorted(by: { $0[keyPath: keyPath] < $1[keyPath: keyPath] })
    }
    
    func sorted(
        by firstPredicate: (Element, Element) -> Bool,
        _ secondPredicate: (Element, Element) -> Bool,
        _ otherPredicates: ((Element, Element) -> Bool)...
    ) -> [Element] {
        return sorted(by:) { lhs, rhs in
            if firstPredicate(lhs, rhs) { return true }
            if firstPredicate(rhs, lhs) { return false }
            if secondPredicate(lhs, rhs) { return true }
            if secondPredicate(rhs, lhs) { return false }
            for predicate in otherPredicates {
                if predicate(lhs, rhs) { return true }
                if predicate(rhs, lhs) { return false }
            }
            return false
        }
    }
}

extension Binding {
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        Binding(
            get: { self.wrappedValue },
            set: { newValue in
                self.wrappedValue = newValue
                handler(newValue)
            }
        )
    }
}

extension URL {
    func getURLFor(_ fileName: String, mimeType: String = "mp4") -> URL {
        URL(fileURLWithPath: Bundle.main.path(forResource: fileName, ofType: mimeType)!)
    }
}
