import Foundation

struct CipherFactory {

    private var ciphers: [String: Cipher] = [
        "Ceasar": CeaserCipher(),
        "AlphaNumeric": AlphaNumericCeasarCipher(),
        "Mirror": Mirror(),
        "PigLatin": PigLatin(),
    ]

    func cipher(for key: String) -> Cipher {
        return ciphers[key]!
    }
}
