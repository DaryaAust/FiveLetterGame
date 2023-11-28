//
//  UserDefaultWrapper.swift
//  FiveLetterGame
//
//  Created by Дарья Ауст on 24.11.2023.
//

import Foundation

public protocol AnyOptional {
    var isNil: Bool { get }
}

extension Optional: AnyOptional {
    public var isNil: Bool { self == nil }
}

@propertyWrapper
struct UserDefault<Value> {
    let key: String
    let defaultValue: Value
    var container: UserDefaults = .standard

    var wrappedValue: Value {
            get {
                return container.object(forKey: key) as? Value ?? defaultValue
            }
            set {
                if let optional = newValue as? AnyOptional, optional.isNil {
                    container.removeObject(forKey: key)
                } else {
                    container.set(newValue, forKey: key)
                }
            }
        }
}
