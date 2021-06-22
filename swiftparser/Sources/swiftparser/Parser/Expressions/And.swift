//
//  And.swift
//  swiftparser
//
//  Created by Nuno Silva on 22/06/2021.
//

import Foundation

extension Parser {

    func and() throws -> ExpressionProtocol {

        var expression = try self.equality()

        while self.matches(types: .and) {

            let op = self.previous
            let right = try self.equality()

            expression = LogicalExpression(left: expression, op: op, right: right)
        }

        return expression
    }
}
