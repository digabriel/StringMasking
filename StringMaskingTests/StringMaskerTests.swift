//
//  Copyright © 2019 Dimas Gabriel. All rights reserved.
//

import XCTest
@testable import StringMasking

class StringMaskingTests: XCTestCase {
    func test_symbolsExtraction_extractsSymbolsWithMaskWithoutSymbols() {
        let mask = ""
        let sut = StringMasker(mask: mask)
        let extracted = sut.extractedSymbols
        
        XCTAssertEqual(extracted, [:])
    }
    
    func test_symbolsExtraction_extractsSymbolsWithMaskWithTwoSymbol() {
        let mask = "+ "
        let sut = StringMasker(mask: mask)
        let extracted = sut.extractedSymbols
        
        XCTAssertEqual(extracted, [0 : "+", 1 : " "])
    }
    
    func test_symbolsExtraction_extractsSymbolsWithMaskWithSymbolsAndOneMaskCharacter() {
        let mask = "+# "
        let sut = StringMasker(mask: mask)
        let extracted = sut.extractedSymbols
        
        XCTAssertEqual(extracted, [0 : "+", 2 : " "])
    }
    
    func test_symbolsExtraction_extractsSymbolsWithMaskWithSymbolsAndMultipleMaskCharacters() {
        let mask = "+# ### - ###"
        let sut = StringMasker(mask: mask)
        let extracted = sut.extractedSymbols
        
        XCTAssertEqual(extracted, [0 : "+", 2 : " ", 6 : " ", 7 : "-", 8 : " "])
    }
}
