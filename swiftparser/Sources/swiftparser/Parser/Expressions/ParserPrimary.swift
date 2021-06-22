//
//  Primary.swift
//  swiftparser
//
//  Created by Nuno Silva on 22/06/2021.
//

import Foundation

extension Parser {

    func primary() throws -> ExpressionProtocol {

        if self.matches(types: .false) {

            return LiteralExpression(value: false)
        }

        if self.matches(types: .true) {

            return LiteralExpression(value: true)
        }

        if self.matches(types: .number) {

            assert(self.previous.literal != nil, "Expected valid number")

            return LiteralExpression(value: self.previous.literal!)
        }

        if self.matches(types: .identifier) {

            return VariableExpression(name: self.previous)
        }

        if self.matches(types: .leftParenthesis) {

            let expression = try self.expression()

            _ = try self.consume(tokenType: .rightParenthesis, message: "Expected ')' after expression.")

            return GroupingExpression(expression: expression)
        }

        let token = self.peek

        self.errorCallback?(token.line, "Expected expression")

        throw ParseError()
    }
}
