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

        guard let line = readLine() else {

            break
        }

        print(">")

        let scanner = Scanner(source: line)

        scanner.errorCallback = { line, message in

            print("Error at line \(line): \(message)")
        }

        scanner.scanTokens()

        let parser = Parser(tokens: scanner.tokens)

        parser.errorCallback = { line, message in

            print("Error at line \(line): \(message)")
        }

        let statements: [StatementProtocol]

        do {

            statements = try parser.parse()

        } catch {

            continue
        }
    }
}

