import Foundation

private struct ASTError: Error {}

func ASTGen(grammarPath: String, statementPath: String, outPath: String) {

    let fileManager = FileManager.default
    
    let grammarData: String
    let statementData: String
    
    do {
        
        grammarData = try String(contentsOfFile: grammarPath)
        statementData = try String(contentsOfFile: statementPath)
        
    } catch {
        
        print("Failed to load data")
        
        return
    }
    
    let grammarLines = grammarData.split(separator: "\n")
        .compactMap { $0.trimmingCharacters(in: .whitespacesAndNewlines) }

    var lineNumber = 0
    var classNames = [String]()
    
    for line in grammarLines {
        
        if line.count == 0 {
            
            lineNumber += 1
            
            continue
        }
        
        let pair = line.split(separator: ":")
        
        guard pair.count == 2 else {
            
            print("on line \(lineNumber): Invalid syntax: Expected name and parameters separated by `:'.")
            
            return
        }
        
        let className = String(pair[0]).trimmingCharacters(in: .whitespacesAndNewlines)
        let fields = String(pair[1]).trimmingCharacters(in: .whitespacesAndNewlines)
        
        if className.count == 0 || fields.count == 0 {
            
            print("on line \(lineNumber): Invalid syntax. Expected a valid class name and fields.")
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
            
            print("on line \(lineNumber): Failed to generate AST file")
            
            lineNumber += 1

            continue
        }
        
        lineNumber += 1
    }
    
    //GenerateASTVisitorProtocol("ExpressionVisitor", classNames, "\(outPath)/ExpressionVisitor.swift")
}

private func GenerateASTFile(baseClass: String,
                             visitorBaseClass: String,
                             className: String,
                             fields: String,
                             path: String) throws {
    
    let fieldsList = fields.split(separator: ";")
        .compactMap { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
    
    var source = "class \(className): \(baseClass) {\n    \(className)("
    var inner = ""

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
        
        source += "\(name): \(type)"
        
        inner += "        self.\(name) = \(name)\n"
    }
    
    source += ") {\n\(inner)    }\n"
    
    source += "    func accept(visitor: \(visitorBaseClass)) -> Any? {\n        return visitor.visit\(className)(self)\n    }\n}\n"
    
    try source.write(toFile: path, atomically: true, encoding: .utf8)
}
