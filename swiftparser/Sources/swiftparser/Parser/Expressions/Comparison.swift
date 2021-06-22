//
//  Comparison.swift
//  swiftparser
//
//  Created by Nuno Silva on 22/06/2021.
//

import Foundation

extension Parser {

    func comparison() throws -> ExpressionProtocol {

        var expression = try self.term()

        while self.matches(types: .greater, .greaterEqual, .less, .lessEqual) {

            let op = self.previous
            let right = try self.term()

            expression = BinaryExpression(left: expression,
                                          op: op,
                                          right: right)
        }

        return expression
    }
}
