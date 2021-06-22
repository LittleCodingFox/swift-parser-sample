//
//  InterpreterLiteralExpression.swift
//  swiftparser
//
//  Created by Nuno Silva on 22/06/2021.
//

import Foundation

extension Interpreter {

    func visitLiteralExpression(_ item: LiteralExpression) throws -> Any? {

        return item.value
    }
}
