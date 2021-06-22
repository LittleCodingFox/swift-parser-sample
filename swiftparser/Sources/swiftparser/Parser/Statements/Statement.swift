//
//  Statement.swift
//  swiftparser
//
//  Created by Nuno Silva on 22/06/2021.
//

import Foundation

extension Parser {

    func statement() throws -> StatementProtocol {

        if self.matches(types: .print) {

            return try self.printStatement()
        }

        return try self.expressionStatement()
    }
}
