//
//  InterpreterGroupingExpression.swift
//  swiftparser
//
//  Created by Nuno Silva on 22/06/2021.
//

import Foundation

extension Interpreter {

    func visitGroupingExpression(_ item: GroupingExpression) throws -> Any? {

        return try self.evaluate(expression: item.expression)
    }
}
