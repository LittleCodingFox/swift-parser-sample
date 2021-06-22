//
//  InterpreterVariableStatement.swift
//  swiftparser
//
//  Created by Nuno Silva on 22/06/2021.
//

import Foundation

extension Interpreter {

    func visitVariableStatement(_ item: VariableStatement) throws -> Any? {

        if self.globalVariables.exists(name: item.name.lexeme) {

            throw RuntimeError.error(token: item.name,
                                     message: "Variable `\(item.name.lexeme)' already exists.")
        }

        var value: Any? = nil

        if let initializer = item.initializer {

            value = try self.evaluate(expression: initializer)
        }

        self.globalVariables.set(name: item.name.lexeme,
                                 value: VariableValue(value: value))

        return nil
    }
}
