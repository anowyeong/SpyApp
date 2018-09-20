import Foundation

struct CipherFactory {

    private var ciphers: [String: Cipher] = [
        "Ceasar": CeaserCipher(),
        "AlphaNumeric": AlphaNumericCeasarCipher(),
        "Mirror": Mirror(),
        "AtBash": AtBash(),
    ]

    func cipher(for key: String) -> Cipher {
        return ciphers[key]!
    }
}
