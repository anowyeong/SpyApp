import XCTest
@testable import SpyApp

class AlphaNumericalCeasarCipherTest: XCTestCase {
    
    var cipher: Cipher!
    
    override func setUp() {
        super.setUp()
        cipher = AlphaNumericCeasarCipher()
    }

    func test_lowercasedLetterIsConvertedToCapital() {
        let plaintext = "a"
        
        let test = cipher.encode(plaintext, secret: "0")
       
        let result = cipher.encode("A", secret: "0")
        
        XCTAssertEqual(test, result)
    }
    
    func test_NumericalInputsDontResult_Nil(){
        let plaintext = "7"
        let result = cipher.encode(plaintext, secret: "0")
        
        XCTAssertNotNil(result)
    }
    
    func test_MultipleLowercasedLettersAreConvertedToUppercase() {
        let test = cipher.encode("abc", secret: "0")
        let result = cipher.encode("ABC", secret: "0")
        
        XCTAssertEqual(test, result)
    }
    
    func test_cipherIsMappedToTheNextLetterWith_secret_1() {
        let plaintext = "a"
        let nextCharacter = "b"
        
        let result = cipher.encode(plaintext, secret: "1")
        let test = cipher.encode(nextCharacter, secret: "0")
        
        XCTAssertEqual(result, test)
    }
    
    
    
    
}
