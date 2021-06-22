//
//  Declaration.swift
//  swiftparser
//
//  Created by Nuno Silva on 22/06/2021.
//

import Foundation

extension Parser {

    func declaration() throws -> StatementProtocol {

        do {

            return try self.statement()

        } catch {

            self.synchronize()

            throw error
        }
    }
}
