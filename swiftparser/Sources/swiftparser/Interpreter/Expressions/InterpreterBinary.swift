//
//  Binary.swift
//  swiftparser
//
//  Created by Nuno Silva on 22/06/2021.
//

import Foundation

extension Interpreter {

    func visitBinaryExpression(_ item: BinaryExpression) throws -> Any? {

        guard let left = try self.evaluate(expression: item.left) as? Double,
              let right = try self.evaluate(expression: item.right) as? Double else {

            throw RuntimeError.error(token: item.op, message: "Expected doubles in operator")
        }

        switch item.op.type {

        case .greater:
            return left > right

        case .greaterEqual:
            return left >= right

        case .less:
            return left < right

        case .lessEqual:
            return left <= right

        case .bangEqual:
            return left != right

        case .equalEqual:
            return left == right

        case .plus:
            return left + right

        case .minus:
            return left - right

        case .slash:
            return left / right

        case .star:
            return left * right

        default:
            return nil
        }
    }
}
