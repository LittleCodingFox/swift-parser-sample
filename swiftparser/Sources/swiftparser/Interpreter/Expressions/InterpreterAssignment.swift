//
//  AssignmentExpression.swift
//  swiftparser
//
//  Created by Nuno Silva on 22/06/2021.
//

import Foundation

extension Interpreter {

    func visitAssignmentExpression(_ expression: AssignmentExpression) throws -> Any? {

        let value = try self.evaluate(expression: expression.value)

        self.globalVariables.set(name: expression.name.lexeme, value: VariableValue(value: value))

        return value
    }
}
