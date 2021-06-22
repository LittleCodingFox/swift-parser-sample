//
//  Interpreter.swift
//  swiftparser
//
//  Created by Nuno Silva on 22/06/2021.
//

import Foundation

enum RuntimeError: Error {

    case error(token: Token, message: String)
}

class Interpreter: ExpressionVisitorProtocol, StatementVisitorProtocol {

    var globalVariables = VariableEnvironment()

    var errorCallback: (() -> Void)?
    var runtimeError: ((RuntimeError) -> Void)?

    func interpret(statements: [StatementProtocol]) {

        do {

            for statement in statements {

                try self.execute(statement: statement)
            }

        } catch let RuntimeError.error(token: token, message: message) {

            self.runtimeError?(.error(token: token, message: message))

        } catch {

            self.errorCallback?()
        }
    }

    func execute(statement: StatementProtocol) throws {

        _ = try statement.accept(visitor: self)
    }

    func stringify(_ object: Any?) -> String {

        if object == nil {

            return "nil"
        }

        if let doubleValue = object as? Double {

            var text = "\(doubleValue)"

            if text.hasSuffix(".0") {

                text = String(text[text.startIndex..<text.index(text.startIndex, offsetBy: text.count - 2)])
            }

            return text
        }

        return String(describing: object)
    }

    func validateNumberType(op: Token, operands: Any?...) throws {

        for operand in operands {

            guard let _ = operand as? Double else {

                throw RuntimeError.error(token: op,
                                         message: "Operand must be a number.")
            }
        }
    }

    func isTruth(_ object: Any?) -> Bool {

        guard let boolValue = object as? Bool else {

            return false
        }

        return boolValue
    }

    func evaluate(expression: ExpressionProtocol) throws -> Any? {

        return try expression.accept(visitor: self)
    }
}
