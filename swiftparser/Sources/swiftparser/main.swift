let interpreter = Interpreter()
var hasError = false

interpreter.runtimeError = { error in

    guard case let .error(token: token, message: message) = error else { return }

    print("Error in line \(token.line): \(message)")

    hasError = true
}

if CommandLine.arguments.count > 1 {

    let mode = CommandLine.arguments[1]

    if(mode == "--astgen") {

        if(CommandLine.arguments.count == 5) {

            ASTGen(grammarPath: CommandLine.arguments[2],
                   statementPath: CommandLine.arguments[3],
                   outPath: CommandLine.arguments[4])

        } else {

            print("Usage: \(CommandLine.arguments[0]) --astgen grammar statements outdir")
        }
    }

} else {

    while true {

        print(">")

        guard let line = readLine() else {

            break
        }

        hasError = false

        let scanner = Scanner(source: line)

        scanner.errorCallback = { line, message in

            print("Error at line \(line): \(message)")

            hasError = true
        }

        scanner.scanTokens()

        if hasError {

            continue
        }

        let parser = Parser(tokens: scanner.tokens)

        parser.errorCallback = { line, message in

            print("Error at line \(line): \(message)")

            hasError = true
        }

        let statements: [StatementProtocol]

        do {

            statements = try parser.parse()

        } catch {

            continue
        }

        if hasError {

            continue
        }

        interpreter.interpret(statements: statements)
    }
}

