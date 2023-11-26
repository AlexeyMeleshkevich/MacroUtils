import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest
import URLValidationMacro

let testMacros: [String: Macro.Type] = [
    "URL": URLValidationMacro.self,
]

final class MacroUtilsTests: XCTestCase {
    
    func testValidURL() {
        assertMacroExpansion(
            #"""
            #URL("https://www.apple.com/")
            """#,
            expandedSource: #"""
            URL(string: "https://www.apple.com/")!
            """#,
            macros: testMacros
        )
    }

    func testStaticStringLiteralError() {
        assertMacroExpansion(
            #"""
            #URL("https://www.apple.com/" + "mac/")
            """#,
            // Expanded source not matching URL(string: ...)! construction which indicates error
            // no api for errors test
            expandedSource: #"""
            #URL("https://www.apple.com/" + "mac/")
            """#,
            diagnostics: [
                DiagnosticSpec(message: "#URL macros requires a static string literal", line: 1, column: 1)
            ],
            macros: testMacros
        )
    }
}
