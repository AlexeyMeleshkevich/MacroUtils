import Foundation
import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

/**
 Performs precompile time url validation.
 */
public struct URLValidationMacro: ExpressionMacro {
    
    public static func expansion(of node: some FreestandingMacroExpansionSyntax,
                                 in context: some MacroExpansionContext) throws -> ExprSyntax {
        guard let argument = node.argumentList.first?.expression,
              let segments = argument.as(StringLiteralExprSyntax.self)?.segments, segments.count == 1,
              case .stringSegment(let literalSegment)? = segments.first
        else {
            throw URLValidationMacroError.requiresStaticStringLiteral
        }
        
        // TODO: Add complete validation package
        guard let _ = URL(string: literalSegment.content.text) else {
            throw URLValidationMacroError.invalidURL(urlString: "\(argument)")
        }
        
        return "URL(string: \(argument))!"
    }
}


@main
struct MacroUtilsPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        URLValidationMacro.self,
    ]
}
