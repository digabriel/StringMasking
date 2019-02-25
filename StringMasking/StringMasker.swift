//
//  Copyright © 2019 Dimas Gabriel. All rights reserved.
//

import Foundation

// Currently only support numbers masking with the # mask character

enum MaskCharacter: Character {
    case numbers = "#"
    
    var characterSet: CharacterSet {
        switch self {
        case .numbers:
            return CharacterSet.decimalDigits
        }
    }
}

struct StringMasker {
    private let mask: String
    private(set) var extractedSymbols: [Int : Character]
    
    init(mask: String) {
        self.mask = mask
        self.extractedSymbols = mask.enumerated().reduce([:], { (result, enumeration) -> [Int : Character] in
            var r = result
            if MaskCharacter(rawValue: enumeration.element) == nil {
                r[enumeration.offset] = enumeration.element
            }
            return r
        })
    }
    
    func mask(_ string: String) -> String {
        guard !string.isEmpty else { return "" }
        
        var currentIndex = string.startIndex
        let chars = mask.enumerated().compactMap { (maskEnumeration) -> Character? in
            if let char = extractedSymbols[maskEnumeration.offset] {
                return char
            }else if currentIndex < string.endIndex {
                let c = string[currentIndex]
                currentIndex = string.index(after: currentIndex)
                return c
            }else {
                return nil
            }
        }
        
        return String(chars)
    }
}
