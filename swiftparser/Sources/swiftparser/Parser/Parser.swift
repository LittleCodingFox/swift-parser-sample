//
//  Parser.swift
//  swiftparser
//
//  Created by Nuno Silva on 22/06/2021.
//

import Foundation

struct ParseError: Error {}

class Parser {

    private let tokens: [Token]
    private var current: Int = 0

    var errorCallback: ((Int, String) -> Void)?

    init(tokens: [Token]) {

        self.tokens = tokens
    }
}

extension Parser {

    func parse() -> [StatementProtocol] {

        var statements = [StatementProtocol]()

        while self.EOF == false {

            //statements.append(self.declaration())
        }

        return statements
    }

    func consume(tokenType: TokenType, message: String) throws -> Token {

        if self.check(tokenType: tokenType) {

            return self.advance()
        }

        let token = self.peek

        self.errorCallback?(token.line, message)

        throw ParseError()
    }

    func matches(types: TokenType...) -> Bool {

        for type in types {

            if self.check(tokenType: type) {

                _ = self.advance()

                return true
            }
        }

        return false
    }

    func check(tokenType: TokenType) -> Bool {

        if self.EOF {

            return false
        }

        return self.peek.type == tokenType
    }

    func advance() -> Token {

        if self.EOF == false {

            self.current += 1
        }

        return self.previous
    }

    var previous: Token {

        return self.tokens[self.current - 1]
    }

    var EOF: Bool {

        return self.peek.type == .EOF
    }

    var peek: Token {

        return self.tokens[self.current]
    }
}
