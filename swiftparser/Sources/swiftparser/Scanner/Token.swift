//
//  Token.swift
//  swiftparser
//
//  Created by Nuno Silva on 21/06/2021.
//

import Foundation

class Token {
    
    let type: TokenType
    let lexeme: String
    let literal: Any?
    let line: Int
    
    init(type: TokenType,
         lexeme: String,
         literal: Any?,
         line: Int) {
        
        self.type = type
        self.lexeme = lexeme
        self.literal = literal
        self.line = line
    }
}
