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
}
