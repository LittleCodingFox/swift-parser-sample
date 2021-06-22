//
//  VariableEnvironment.swift
//  swiftparser
//
//  Created by Nuno Silva on 22/06/2021.
//

import Foundation

class VariableEnvironment {

    private var values: [String: VariableValue] = [:]

    func exists(name: String) -> Bool {

        return self.values[name] != nil
    }

    func remove(name: String) {

        self.values[name] = nil
    }

    func assign(name: Token,
                value: Any?) throws {

        if self.values[name.lexeme] != nil {

            self.values[name.lexeme] = VariableValue(value: value)

            return
        }

        throw RuntimeError.error(token: name, message: "Undefined variable `\(name.lexeme)'.")
    }

    func set(name: String,
             value: VariableValue) {

        self.values[name] = value
    }

    func get(name: Token) throws -> VariableValue {

        if let value = self.values[name.lexeme] {

            return value
        }

        throw RuntimeError.error(token: name, message: "Undefined variable `\(name.lexeme)'.")
    }
}
