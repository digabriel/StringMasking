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
    let mask: String
    
    var extractedSymbols: [Int : Character] {
        return mask.enumerated().reduce([:], { (result, enumeration) -> [Int : Character] in
            var r = result
            if MaskCharacter(rawValue: enumeration.element) == nil {
                r[enumeration.offset] = enumeration.element
            }
            return r
        })
    }
}
