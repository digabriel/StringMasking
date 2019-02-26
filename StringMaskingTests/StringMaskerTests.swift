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
    
    func test_onlyNumbersMask_mapNumberStringCorrectly() {
        let stringToMask = "12"
        let sut = StringMasker(mask: "##")
        XCTAssertEqual(sut.mask(stringToMask), "12")
    }
    
    func test_maskBiggerThanString_mapsCorrectly() {
        let stringToMask = "12"
        let sut = StringMasker(mask: "###")
        XCTAssertEqual(sut.mask(stringToMask), "12")
    }
    
    func test_maskSmallerThanString_mapsCorrectly() {
        let stringToMask = "12345"
        let sut = StringMasker(mask: "#+##")
        XCTAssertEqual(sut.mask(stringToMask), "1+23")
    }

    func test_maskWithSymbols_mapsCorrectly() {
        let stringToMask = "1234"
        let sut = StringMasker(mask: "+# ###")
        XCTAssertEqual(sut.mask(stringToMask), "+1 234")
    }
    
    func test_stringWithNonNumbersCharacters_mapsCorrectly() {
        let stringToMask = "12aa567"
        let sut = StringMasker(mask: "+# ###")
        XCTAssertEqual(sut.mask(stringToMask), "+1 2")
    }
    
    func test_phoneMask_mapsPhoneNumber() {
        let phoneNumber = "18005550123"
        let sut = StringMasker(mask: "+# (###) ###-####")
        XCTAssertEqual(sut.mask(phoneNumber), "+1 (800) 555-0123")
    }
    
    func test_maskedString_removesSymbols() {
        let phoneNumber = "+1 (800) 555-0123"
        let sut = StringMasker(mask: "+# (###) ###-####")
        XCTAssertEqual(sut.rawString(from: phoneNumber), "18005550123")
    }
    
    //MARK: - Helpers
    private func extractedSymbolsFromMask(_ mask: String) -> [Int : Character] {
        let sut = StringMasker(mask: mask)
        return sut.extractedSymbols
    }
}
