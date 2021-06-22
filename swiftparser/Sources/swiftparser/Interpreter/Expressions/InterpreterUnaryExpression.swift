//
//  InterpreterUnaryExpression.swift
//  swiftparser
//
//  Created by Nuno Silva on 22/06/2021.
//

import Foundation

extension Interpreter {

    func visitUnaryExpression(_ item: UnaryExpression) throws -> Any? {

        let right = try self.evaluate(expression: item.right)

        switch item.op.type {

        case .bang:
            return !self.isTruth(right)

        case .minus:
            guard let doubleValue = right as? Double else {

                throw RuntimeError.error(token: item.op, message: "Expected number for minus operator")
            }

            return -doubleValue

        default:
            return nil
        }
    }
}
