//
//  InterpreterPrintStatement.swift
//  swiftparser
//
//  Created by Nuno Silva on 22/06/2021.
//

import Foundation

extension Interpreter {

    func visitPrintStatement(_ item: PrintStatement) throws -> Any? {

        let value = try self.evaluate(expression: item.expression)

        print(String(describing: value))

        return nil
    }
}
