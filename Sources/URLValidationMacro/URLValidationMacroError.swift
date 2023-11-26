/**
 List of macros executing errors.
 */
enum URLValidationMacroError: Error, CustomStringConvertible {
    
    /**
     Macros requires string literal.
     */
    case requiresStaticStringLiteral
    
    /**
     Validation failed.
     */
    case invalidURL(urlString: String)

    /**
     Error description.
     */
    var description: String {
        switch self {
        case .requiresStaticStringLiteral:
            return "#URL macros requires a static string literal"
        case .invalidURL(let urlString):
            return "The input URL is not valid: \(urlString)"
        }
    }
}
