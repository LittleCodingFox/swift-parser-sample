//
//  ParserPrintStatement.swift
//  swiftparser
//
//  Created by Nuno Silva on 22/06/2021.
//

import Foundation

extension Parser {

    func printStatement() throws -> StatementProtocol {

        let value = try expression()

        let token = try self.consume(tokenType: .semicolon, message: "Expected `;' after expression.")

        return PrintStatement(token: token,
                              expression: value)
    }
}
