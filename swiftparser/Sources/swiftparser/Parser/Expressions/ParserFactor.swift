//
//  Factor.swift
//  swiftparser
//
//  Created by Nuno Silva on 22/06/2021.
//

import Foundation

extension Parser {

    func factor() throws -> ExpressionProtocol {

        var expression = try self.unary()

        while self.matches(types: .slash, .star) {

            let op = self.previous
            var right = try self.unary()

            expression = BinaryExpression(left: expression,
                                          op: op,
                                          right: right)
        }

        return expression
    }
}
