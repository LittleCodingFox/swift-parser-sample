//
//  InterpreterVariableExpression.swift
//  swiftparser
//
//  Created by Nuno Silva on 22/06/2021.
//

import Foundation

extension Interpreter {

    func visitVariableExpression(_ item: VariableExpression) throws -> Any? {

        return try self.globalVariables.get(name: item.name).value
    }
}
