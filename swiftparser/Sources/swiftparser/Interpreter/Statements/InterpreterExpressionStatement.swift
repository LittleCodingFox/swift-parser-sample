//
//  InterpreterExpressionStatement.swift
//  swiftparser
//
//  Created by Nuno Silva on 22/06/2021.
//

import Foundation

extension Interpreter {

    func visitExpressionStatement(_ item: ExpressionStatement) throws -> Any? {

        _ = try self.evaluate(expression: item.expression)

        return nil
    }
}
