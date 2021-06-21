//
//  StatementProtocol.swift
//  swiftparser
//
//  Created by Nuno Silva on 21/06/2021.
//

import Foundation

protocol StatementProtocol {

    func accept(visitor: StatementVisitorProtocol) -> Any?
}

