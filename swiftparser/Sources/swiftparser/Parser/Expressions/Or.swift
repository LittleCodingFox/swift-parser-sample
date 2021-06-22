//
//  Or.swift
//  swiftparser
//
//  Created by Nuno Silva on 22/06/2021.
//

import Foundation

extension Parser {

    func or() throws -> ExpressionProtocol {

        var expression = try self.and()

        while self.matches(types: .or) {

            let op = previous
            let right = try self.and()

            expression = LogicalExpression(left: expression,
                                           op: op,
                                           right: right)
        }

        return expression
    }
}
