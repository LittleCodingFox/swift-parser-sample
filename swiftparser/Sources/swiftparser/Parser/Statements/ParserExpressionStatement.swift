//
//  ExpressionStatement.swift
//  swiftparser
//
//  Created by Nuno Silva on 22/06/2021.
//

import Foundation

extension Parser {

    func expressionStatement() throws -> StatementProtocol {

        let expression = try self.expression()

        _ = try self.consume(tokenType: .semicolon, message: "Expected `;' after expression.")

        return ExpressionStatement(expression: expression)
    }
}
