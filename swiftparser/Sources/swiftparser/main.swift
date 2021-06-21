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

        let scanner = Scanner(source: line)

        scanner.errorCallback = { line, message in

            print("Error at line \(line): \(message)")
        }

        scanner.scanTokens()

        for token in scanner.tokens {

            print(token.type)
        }
    }
}

