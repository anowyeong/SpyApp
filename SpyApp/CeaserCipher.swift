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
        let array = [65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,70,81,82,83,84,85,86,87,88,89,90,48,49,50,51,52,53,54,55,56,57] //array holding the possible outputs
        
        var encoded = ""
        
        for character in plaintext {
            var unicode = character.unicodeScalars.first!.value
            
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
                var i = 0
                while array[i] != unicode {
                    i += 1
                }
                //let shiftedUnicode:UInt8 = UInt8((array[i] + Int(shiftBy)) % 36)               // mod 36 because there are 26 letters and 10 numbers; N = 36
                
            let shiftedIndex: Int = ((i) + shiftBy) % 36
                
            //let shiftedUnicode = unicode + shiftBy
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
        
        let array = [65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,70,81,82,83,84,85,86,87,88,89,90,48,49,50,51,52,53,54,55,56,57]
        
        var decoded = ""
        
        for character in outputtext {
            var unicode = character.unicodeScalars.first!.value
            
            switch unicode {
            case 32,48...57,65...90,97...122:
                while unicode > 96 && unicode < 123 {
                    unicode = unicode - 32
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

 struct PigLatin: Cipher {
    func encode(_ plaintext: String, secret: String) -> String? {
        
        return nil
        
        
        
    }
        
        
        
    func decrypt(outputtext: String, secret: String) -> String? {
        return nil
    }
        
        
        
 }
    

