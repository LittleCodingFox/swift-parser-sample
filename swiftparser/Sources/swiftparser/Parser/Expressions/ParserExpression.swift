//
//  Expression.swift
//  swiftparser
//
//  Created by Nuno Silva on 22/06/2021.
//

import Foundation

extension Parser {

    func expression() throws -> ExpressionProtocol {

        return try self.assignment()
    }
}
