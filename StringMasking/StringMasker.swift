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
    
    func contains(character c: Character) -> Bool {
        let set = CharacterSet(charactersIn: "\(c)")
        return set.isSubset(of: characterSet)
    }
}

public struct StringMasker {
    private let mask: String
    private(set) var extractedSymbols: [Int : Character]
    
    public init(mask: String) {
        self.mask = mask
        self.extractedSymbols = mask.enumerated().reduce([:], { (result, enumeration) -> [Int : Character] in
            var r = result
            if MaskCharacter(rawValue: enumeration.element) == nil {
                r[enumeration.offset] = enumeration.element
            }
            return r
        })
    }
    
    public func mask(_ string: String) -> String {
        guard !string.isEmpty else { return "" }
        
        var currentIndex = string.startIndex
        let chars = mask.enumerated().compactMap { (maskEnumeration) -> Character? in
            if currentIndex >= string.endIndex {
                return nil
            }
            
            if let char = extractedSymbols[maskEnumeration.offset] {
                return char
            }else {
                let c = string[currentIndex]
                currentIndex = string.index(after: currentIndex)
                
                if let maskCharacter = MaskCharacter(rawValue: maskEnumeration.element) {
                    return maskCharacter.contains(character: c) ? c : nil
                }else {
                    return nil
                }
            }
        }
        
        return String(chars)
    }
    
    public func rawString(from maskedString: String) -> String {
        return maskedString.filter {!extractedSymbols.values.contains($0)}
    }
}
