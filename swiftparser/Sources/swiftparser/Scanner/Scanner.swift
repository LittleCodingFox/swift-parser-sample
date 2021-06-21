//
//  Scanner.swift
//  swiftparser
//
//  Created by Nuno Silva on 21/06/2021.
//

import Foundation

class Scanner {

    private let source: String
    private var start: Int
    private var current: Int
    private var line: Int

    var errorCallback: ((Int, String) -> Void)?

    private(set) var tokens: [Token] = []

    init(source: String) {

        self.source = source

        self.start = 0
        self.current = 0
        self.line = 1
    }

    func scanTokens() {

        while self.EOF == false {

            self.start = self.current

            self.scanToken()
        }

        self.tokens.append(Token(type: .EOF, lexeme: "", literal: nil, line: self.line))
    }
}

private extension Scanner {

    func scanToken() {

        let c = self.next

        switch(c) {

        case "(":
            self.addToken(.leftParenthesis)

        case ")":
            self.addToken(.rightParenthesis)

        case ",":
            self.addToken(.comma)

        case ":":
            self.addToken(.colon)

        case ".":
            self.addToken(.dot)

        case "-":
            self.addToken(.minus)

        case "+":
            self.addToken(.plus)

        case ";":
            self.addToken(.semicolon)

        case "*":
            self.addToken(.star)

        case "!":
            self.addToken(self.matches("=") ? .bangEqual : .bang)

        case "=":
            self.addToken(self.matches("=") ? .equalEqual : .equal)

        case "<":
            self.addToken(self.matches("=") ? .lessEqual : .less)

        case ">":
            self.addToken(self.matches("=") ? .greaterEqual : .greater)

        case "/":
            if self.matches("/") {

                while self.peek != "\n" && !self.EOF {

                    _ = self.next
                }

            } else {

                self.addToken(.slash)
            }

        case " ",
             "\r",
             "\t":

            break

        case "\n":
            self.line += 1

        case "o":
            if(self.matches("r")) {

                self.addToken(.or)
            }
        default:

            if c.isNumber {

                self.handleNumber()

            } else if self.isAlpha(c) {

                self.handleIdentifier()

            } else {

                self.errorCallback?(self.line, "Unexpected character")
            }
        }
    }

    func isAlpha(_ c: Character) -> Bool {

        return (c >= "a" && c <= "z") ||
            (c >= "A" && c <= "Z") ||
            c == "_"
    }

    func isAlphaNumeric(_ c: Character) -> Bool {

        return self.isAlpha(c) || c.isNumber
    }

    func handleIdentifier() {

        while self.isAlphaNumeric(self.peek) {

            _ = self.next
        }

        let text = self.source[self.source.index(self.source.startIndex, offsetBy: self.start)..<self.source.index(self.source.startIndex, offsetBy: self.current - self.start)]

        if let tokenType = Keywords.Keyword(identifier: String(text)) {

            self.addToken(tokenType)

        } else {

            self.addToken(.identifier)
        }
    }

    func handleNumber() {

        while self.peek.isNumber {

            _ = self.next
        }

        if(self.peek == "." && self.peekNext.isNumber) {

            _ = self.next

            while self.peek.isNumber {

                _ = self.next
            }
        }

        if let number = Double(self.source[self.source.index(self.source.startIndex, offsetBy: self.start)..<self.source.index(self.source.startIndex, offsetBy: self.current)]) {

            self.addToken(.number, number)

        } else {

            self.errorCallback?(self.line, "Invalid number")
        }
    }

    func matches(_ c: Character) -> Bool {

        if self.EOF || self.source[self.source.index(self.source.startIndex, offsetBy: self.current)] != c {

            return false
        }

        self.current += 1

        return true
    }

    func addToken(_ tokenType: TokenType) {

        self.addToken(tokenType, nil)
    }

    func addToken(_ tokenType: TokenType, _ literal: Any?) {

        let lexeme = self.source[self.source.index(self.source.startIndex, offsetBy: self.start)..<self.source.index(self.source.startIndex, offsetBy: self.current)]

        self.tokens.append(Token(type: tokenType,
                                 lexeme: String(lexeme),
                                 literal: literal,
                                 line: self.line))
    }

    var EOF: Bool {

        return self.current == self.source.count
    }

    var next: Character {

        let value = self.source[self.source.index(self.source.startIndex, offsetBy: self.current)]

        self.current += 1

        return value
    }

    var peek: Character {

        if(self.EOF) {

            return "\0"
        }

        return self.source[self.source.index(self.source.startIndex, offsetBy: self.current)]
    }

    var peekNext: Character {

        if self.current == self.source.count {

            return "\0"
        }

        return self.source[self.source.index(self.source.startIndex, offsetBy: self.current)]
    }
}

