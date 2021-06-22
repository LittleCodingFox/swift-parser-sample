//
//  Unary.swift
//  swiftparser
//
//  Created by Nuno Silva on 22/06/2021.
//

import Foundation

extension Parser {

    func unary() throws -> ExpressionProtocol {

        if self.matches(types: .bang, .minus) {

            let op = self.previous
            let right = try self.unary()

            return UnaryExpression(op: op,
                                   right: right)
        }

        return try self.primary()
    }
}
