import XCTest
@testable import SpyApp

class MirrorCipherTest: XCTestCase {
    
    var cipher: Cipher!
    
    override func setUp() {
        super.setUp()
        cipher = Mirror()
    }
    
    func test_StringIsReversedWithSecret_0() {
        let plaintext = "abc"
        let reversedText = "cba"
        
        let test = cipher.encode(plaintext, secret: "0")
        
        XCTAssertEqual(reversedText, test)
    }
    
    func test_NumbersAreReversedWithSecret_0 () {
        let plaintext = "123"
        let reversedtext = "321"

        let test = cipher.encode(plaintext , secret: "0")
        
        XCTAssertEqual(test, reversedtext)
    }
    
    func test_NumbersWithCharactersAreCompatible() {
        let plaintext = "a1b2"
        let reversedText = "2b1a"
        
        let test = cipher.encode(plaintext, secret: "0")
        
        XCTAssertEqual(test, reversedText)
    }
}
