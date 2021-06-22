//
//  Assignment.swift
//  swiftparser
//
//  Created by Nuno Silva on 22/06/2021.
//

import Foundation

extension Parser {

    func assignment() throws -> ExpressionProtocol {

        var expression = try self.or()

        if self.matches(types: .equal) {

            let equal = self.previous
            let value = try self.assignment()

            if let variableExpression = expression as? VariableExpression {

                return AssignmentExpression(name: variableExpression.name,
                                            value: value)
            }

            self.errorCallback?(equal.line, "Expected assignment target.")

            throw ParseError()
        }

        return expression
    }
}
