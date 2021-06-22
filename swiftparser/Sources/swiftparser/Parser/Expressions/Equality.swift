//
//  Equality.swift
//  swiftparser
//
//  Created by Nuno Silva on 22/06/2021.
//

import Foundation

extension Parser {

    func equality() throws -> ExpressionProtocol {

        var expression = try self.comparison()

        while self.matches(types: .bangEqual, .equalEqual) {

            let op = self.previous
            let right = try self.comparison()

            expression = BinaryExpression(left: expression,
                                          op: op,
                                          right: right)
        }

        return expression
    }
}
