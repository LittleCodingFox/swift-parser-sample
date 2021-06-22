//
//  InterpreterLogicalExpression.swift
//  swiftparser
//
//  Created by Nuno Silva on 22/06/2021.
//

import Foundation

extension Interpreter {

    func visitLogicalExpression(_ item: LogicalExpression) throws -> Any? {

        let left = try self.evaluate(expression: item.left)

        if item.op.type == .or {

            if self.isTruth(left) {

                return true
            }
        }
        else {

            if self.isTruth(left) == false {

                return false
            }
        }

        return try self.evaluate(expression: item.right)
    }
}
