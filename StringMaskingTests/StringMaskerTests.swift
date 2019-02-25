//
//  Copyright © 2019 Dimas Gabriel. All rights reserved.
//

import XCTest
@testable import StringMasking

class StringMaskingTests: XCTestCase {
    func test_symbolsExtraction_extractsSymbolsWithMaskWithoutSymbols() {
        XCTAssertEqual(extractedSymbolsFromMask(""), [:])
    }
    
    func test_symbolsExtraction_extractsSymbolsWithMaskWithTwoSymbol() {
        XCTAssertEqual(extractedSymbolsFromMask("+ "), [0 : "+", 1 : " "])
    }
    
    func test_symbolsExtraction_extractsSymbolsWithMaskWithSymbolsAndOneMaskCharacter() {
        XCTAssertEqual(extractedSymbolsFromMask("+# "), [0 : "+", 2 : " "])
    }
    
    func test_symbolsExtraction_extractsSymbolsWithMaskWithSymbolsAndMultipleMaskCharacters() {
        XCTAssertEqual(extractedSymbolsFromMask("+# ### - ###"), [0 : "+", 2 : " ", 6 : " ", 7 : "-", 8 : " "])
    }
    
    //MARK: - Helpers
    private func extractedSymbolsFromMask(_ mask: String) -> [Int : Character] {
        let sut = StringMasker(mask: mask)
        return sut.extractedSymbols
    }
}
