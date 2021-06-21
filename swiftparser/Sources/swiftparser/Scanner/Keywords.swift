//
//  Keywords.swift
//  swiftparser
//
//  Created by Nuno Silva on 21/06/2021.
//

import Foundation

class Keywords {
    
    private static var keywords: [String: TokenType] = [
        "and": .and,
        "or": .or,
        "false": .false,
        "true": .true,
        "print": .print,
    ]
    
    static func Keyword(identifier: String) -> TokenType? {
        
        return Self.keywords[identifier]
    }
}
