import Foundation

private struct ASTError: Error {}

func ASTGen(grammarPath: String, statementPath: String, outPath: String) {

    let grammarData: String
    let statementData: String

    do {

        grammarData = try String(contentsOfFile: grammarPath)
        statementData = try String(contentsOfFile: statementPath)

    } catch {

        print("Failed to load data")

        return
    }

    var lines = grammarData.split(separator: "\n")
        .compactMap { $0.trimmingCharacters(in: .whitespacesAndNewlines) }

    var lineNumber = 0
    var classNames = [String]()

    for line in lines {

        if line.count == 0 {

            lineNumber += 1

            continue
        }

        let pair = line.split(separator: ":")

        guard pair.count == 2 else {

            print("[Grammar] on line \(lineNumber): Invalid syntax: Expected name and parameters separated by `:'.")

            return
        }

        let className = String(pair[0]).trimmingCharacters(in: .whitespacesAndNewlines)
        let fields = String(pair[1]).trimmingCharacters(in: .whitespacesAndNewlines)

        if className.count == 0 || fields.count == 0 {

            print("[Grammar] on line \(lineNumber): Invalid syntax. Expected a valid class name and fields.")
        }

        classNames.append(className)

        let filePath = "\(outPath)/\(className).swift"

        do {

            try GenerateASTFile(baseClass: "ExpressionProtocol",
                                visitorBaseClass: "ExpressionVisitorProtocol",
                                className: className,
                                fields: fields,
                                path: filePath)

        } catch {

            print("[Grammar] on line \(lineNumber): Failed to generate AST file")

            lineNumber += 1

            continue
        }

        lineNumber += 1
    }

    do {

        try GenerateASTVisitorProtocol(baseClass: "ExpressionVisitorProtocol",
                                       classNames: classNames,
                                       path: "\(outPath)/ExpressionVisitorProtocol.swift")
    } catch {

        print("[Grammar] Failed to generate AST visitor protocol")
    }

    lines = statementData.split(separator: "\n")
        .compactMap { $0.trimmingCharacters(in: .whitespacesAndNewlines) }

    lineNumber = 0
    classNames = [String]()

    for line in lines {

        if line.count == 0 {

            lineNumber += 1

            continue
        }

        let pair = line.split(separator: ":")

        guard pair.count == 2 else {

            print("[Statement] on line \(lineNumber): Invalid syntax: Expected name and parameters separated by `:'.")

            return
        }

        let className = String(pair[0]).trimmingCharacters(in: .whitespacesAndNewlines)
        let fields = String(pair[1]).trimmingCharacters(in: .whitespacesAndNewlines)

        if className.count == 0 || fields.count == 0 {

            print("[Statement] on line \(lineNumber): Invalid syntax. Expected a valid class name and fields.")
        }

        classNames.append(className)

        let filePath = "\(outPath)/\(className).swift"

        do {

            try GenerateASTFile(baseClass: "StatementProtocol",
                                visitorBaseClass: "StatementVisitorProtocol",
                                className: className,
                                fields: fields,
                                path: filePath)

        } catch {

            print("[Statement] on line \(lineNumber): Failed to generate AST file")

            lineNumber += 1

            continue
        }

        lineNumber += 1
    }

    do {

        try GenerateASTVisitorProtocol(baseClass: "StatementVisitorProtocol",
                                       classNames: classNames,
                                       path: "\(outPath)/StatementVisitorProtocol.swift")

    } catch {

        print("[Statement] Failed to generate AST visitor protocol")
    }

}

private func GenerateASTFile(baseClass: String,
                             visitorBaseClass: String,
                             className: String,
                             fields: String,
                             path: String) throws {

    let fieldsList = fields.split(separator: ";")
        .compactMap { $0.trimmingCharacters(in: .whitespacesAndNewlines) }

    var source = "class \(className): \(baseClass) {\n\n    init("
    var inner = ""
    var fieldsSource = ""

    var first = true

    for field in fieldsList {

        if first {

            first = false

        } else {

            source += ", "
        }

        let fieldParts = field.split(separator: " ")

        if fieldParts.count < 2 {

            throw ASTError()
        }

        let type = fieldParts[0..<fieldParts.count - 1].joined(separator: " ")
            .trimmingCharacters(in: .whitespacesAndNewlines)
        let name = fieldParts[fieldParts.count - 1]
            .trimmingCharacters(in: .whitespacesAndNewlines)

        fieldsSource += "    let \(name): \(type)\n"

        source += "\(name): \(type)"

        inner += "        self.\(name) = \(name)\n"
    }

    source += ") {\n\(inner)    }\n\n\(fieldsSource)\n"

    source += "    func accept(visitor: \(visitorBaseClass)) -> Any? {\n        return visitor.visit\(className)(self)\n    }\n}\n"

    try source.write(toFile: path, atomically: true, encoding: .utf8)
}

private func GenerateASTVisitorProtocol(baseClass: String,
                                        classNames: [String],
                                        path: String) throws {
    var source = "protocol \(baseClass) {\n"

    for className in classNames {

        source += "    func visit\(className)(_ item: \(className)) -> Any?\n"
    }

    source += "}\n"

    try source.write(toFile: path, atomically: true, encoding: .utf8)
}

