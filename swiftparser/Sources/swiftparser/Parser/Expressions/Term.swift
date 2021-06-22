//
//  Term.swift
//  swiftparser
//
//  Created by Nuno Silva on 22/06/2021.
//

import Foundation

extension Parser {

    func term() throws -> ExpressionProtocol {

        var expression = try self.factor()

        while self.matches(types: .minus, .plus) {

            let op = self.previous
            let right = try self.factor()

            expression = BinaryExpression(left: expression,
                                          op: op,
                                          right: right)
        }

        return expression
    }
}
