//
//  ExpressionProtocol.swift
//  swiftparser
//
//  Created by Nuno Silva on 21/06/2021.
//

import Foundation

protocol ExpressionProtocol {
    
    func accept(visitor: ExpressionVisitorProtocol) -> Any?
}
