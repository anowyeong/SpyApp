import XCTest
@testable import SpyApp

class AtBashTests: XCTestCase {
    
    var cipher: Cipher!
    
    override func setUp() {
        super.setUp()
        cipher = AtBash()
    }
    
    func test_ResultsAreCapitalized() {
        let plaintext = "a"
        let result = "Z"
        
        let test = cipher.encode(plaintext, secret: "0")
        
        XCTAssertEqual(result, test)
    }
    
    func test_LettersAreSwitchCorrectlyWithSecret_0 () {
        let plaintext = "aey"
        
        let result = "ZVB"
        let test = cipher.encode(plaintext, secret: "0")
        
        XCTAssertEqual(test, result)
    }
    
    
    
}
