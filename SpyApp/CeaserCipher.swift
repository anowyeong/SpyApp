import Foundation

protocol Cipher {
    func encode(_ plaintext: String, secret: String) -> String?
    
    func decrypt( outputtext: String, secret: String) -> String?
}

struct CeaserCipher: Cipher {

    func encode(_ plaintext: String, secret: String) -> String? {
        guard let shiftBy = UInt32(secret) else {
            return nil
        }
        var encoded = ""

        for character in plaintext {
            let unicode = character.unicodeScalars.first!.value
            let shiftedUnicode = unicode + shiftBy
            let shiftedCharacter = String(UnicodeScalar(UInt8(shiftedUnicode)))
            encoded = encoded + shiftedCharacter
        }
        return encoded
    }
    
    func decrypt( outputtext: String, secret: String) -> String? {
        guard let shiftBy = UInt32(secret) else {
            return nil
        }
        var decoded = ""
        
        for character in outputtext {
            let unicode = character.unicodeScalars.first!.value
            let shiftedUnicode = unicode - shiftBy
            let shiftedCharacter = String(UnicodeScalar(UInt8(shiftedUnicode)))
            decoded = decoded + shiftedCharacter
        }
        return decoded
    }
}


struct AlphaNumericCeasarCipher: Cipher {
    
    func encode(_ plaintext: String, secret: String) -> String? {
        guard let shiftBy = Int(secret) else {
            return nil
        }
        //array holding the possible outputs
        let array = [65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,48,49,50,51,52,53,54,55,56,57]
        
        var encoded = ""
        
        for character in plaintext {
            var unicode = character.unicodeScalars.first!.value
            
            //checks for lower cased inputs and converts them to capital case
            switch unicode {
            case 32,48...57,65...90,97...122:
                while unicode > 96 && unicode < 123 {
                    unicode = unicode - 32
                }
            default:
                encoded = "invalid input detected"
                return encoded
            }
            if unicode != 32 {
                // i is the index number of the array
                var i = 0
                while array[i] != unicode {
                    i += 1
                }
                
            // mod 36 because there are 26 letters and 10 numbers; N = 36
            let shiftedIndex: Int = ((i) + shiftBy) % 36
            let shiftedChar: String = String(UnicodeScalar(array[shiftedIndex])!)
            encoded += shiftedChar
            } else {
                encoded += String(UnicodeScalar(UInt8(32)))
            }
        }
        return encoded
    }
    
    func decrypt(outputtext: String, secret: String) -> String? {
        guard let shiftBy = Int(secret) else {
            return nil
        }
        // An array that holds the unicode value of the possible outputs
        let array = [65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,48,49,50,51,52,53,54,55,56,57]
        
        var decoded = ""
        
        for character in outputtext {
            var unicode = character.unicodeScalars.first!.value
            
            // this switch checks for inputs of space, capital/lower case letters
        
            switch unicode {
            case 32,48...57,65...90,97...122:
                while unicode > 96 && unicode < 123 {
                    unicode = unicode - 32              //converts lower cased letters to capital
                }
            default:
                decoded = "invalid input detected"
                return decoded
            }
            
            if unicode != 32 {
                var i = 0
                while array[i] != unicode {
                    i += 1
                }
                
                let shiftedIndex: Int = ((i) - shiftBy) % 36
                let shiftedChar: String = String(UnicodeScalar(array[shiftedIndex])!)
                decoded += shiftedChar
            } else {
                decoded += String(UnicodeScalar(UInt8(32)))
            }
        }
        return decoded
        }
}
// Mirror will create a mirror version of the message, while also changing the character value by the secret.
// The letters at the front will be exchanged with the mirrors at the end of the string, then converted using a cipher.
// Capital and lower case letters, space and special charaacters such as : @,#,$,% , etc are accepted in both inputs and outputs
// It is possible to have only spaces as an input/output


struct Mirror: Cipher {
        func encode(_ plaintext: String, secret: String) -> String? {
            guard let shiftBy = UInt32(secret) else {
                return nil
            }
            var encoded = ""
            let reversePlainText = plaintext.reversed()
        
            for char in reversePlainText {
                let unicode = char.unicodeScalars.last!.value
                if unicode < 32 && unicode > 126{
                    encoded = "Invalid character detected"
                } else {
                var shiftedUnicode = ((unicode + shiftBy) % 127)
                    if shiftedUnicode < 32 { shiftedUnicode += 32}
                let shiftedChar = String(UnicodeScalar(UInt8(shiftedUnicode)))
                encoded += shiftedChar
                }
            }
         return encoded
        }
    
        func decrypt(outputtext: String, secret: String) -> String? {
            guard let shiftBy = UInt32(secret) else {
                return nil
            }
            var decoded = ""
            let reversePlainText = outputtext.reversed()
            
            for char in reversePlainText {
                let unicode = char.unicodeScalars.last!.value
                if unicode < 32 && unicode > 126{
                    decoded = "Invalid character detected"
                } else {
                    var shiftedUnicode = ((unicode - shiftBy) % 127)
                    if shiftedUnicode < 32 { shiftedUnicode += 32}
                    let shiftedChar = String(UnicodeScalar(UInt8(shiftedUnicode)))
                    decoded += shiftedChar
                }
            }
            return decoded
        }
}


// Letters and spaces are allowed in this cipher
// Output will only consist of capital letters
// This AtBash will switch the letters from accending to descending order; A <-> Z, B <-> Y

 struct AtBash: Cipher {
    func encode(_ plaintext: String, secret: String) -> String? {
        guard let shiftBy = Int(secret) else {
            return nil
        }
        //first half of the alphabet
        let arr1 = [65,66,67,68,69,70,71,72,73,74,75,76,77]
        // second half of the alphabet
        let arr2 = [90,89,88,87,86,85,84,83,82,81,80,79,78]
        
        var encoded = ""
        
        for char in plaintext{
            var unicode = char.unicodeScalars.first!.value
            
            switch unicode {
                case 32,65...90,97...122:
                    while unicode > 96 && unicode < 123 {
                        unicode = unicode - 32
                    }
                default:
                    encoded = "invalid input detected"
                    return encoded
            }
            
            if (unicode != 32 && unicode < 78) {
                var i = 0
                
                while (unicode != arr1[i]) {
                i += 1
                }
                
                let shiftedIndex = Int(i + shiftBy) % 13
                
                let shiftedChar = arr2[shiftedIndex]
                
                guard let value = UnicodeScalar(UInt32(shiftedChar)) else {
                    encoded = "Error"
                    return encoded
                }
                encoded += String(value)
        
            } else if (unicode > 77) {
                var i = 0
                
                while (unicode != arr2[i]){
                    i += 1
                }
                let shiftedIndex = Int(i + shiftBy) % 13
                
                let shiftedChar = arr1[shiftedIndex]
                
                guard let value = UnicodeScalar(UInt32(shiftedChar)) else {
                    encoded = "Error"
                    return encoded
                }
                encoded += String(value)
            } else {
                encoded += " "
            }
        }
        return encoded
    }
        
    func decrypt(outputtext: String, secret: String) -> String? {
        guard let shiftBy = Int(secret) else {
            return nil
        }
        //first half of the alphabet
        let arr1 = [65,66,67,68,69,70,71,72,73,74,75,76,77]
        // second half of the alphabet
        let arr2 = [90,89,88,87,86,85,84,83,82,81,80,79,78]
        
        var decoded = ""
        
        for char in outputtext{
            var unicode = char.unicodeScalars.first!.value
            
            switch unicode {
            case 32,65...90,97...122:
                while unicode > 96 && unicode < 123 {
                    unicode = unicode - 32
                }
            default:
                decoded = "invalid input detected"
                return decoded
            }
            
            if (unicode != 32 && unicode < 78) {
                var i = 0
                
                while (unicode != arr1[i]) {
                    i += 1
                }
                
                let shiftedIndex = Int(i - shiftBy) % 13
                
                let shiftedChar = arr2[shiftedIndex]
                
                guard let value = UnicodeScalar(UInt32(shiftedChar)) else {
                    decoded = "Error"
                    return decoded
                }
                decoded += String(value)
                
            } else if (unicode > 77) {
                var i = 0
                
                while (unicode != arr2[i]){
                    i += 1
                }
                let shiftedIndex = Int(i - shiftBy) % 13
                
                let shiftedChar = arr1[shiftedIndex]
                
                guard let value = UnicodeScalar(UInt32(shiftedChar)) else {
                    decoded = "Error"
                    return decoded
                }
                decoded += String(value)
            } else {
                decoded += " "
            }
        }
        return decoded
    }
}

