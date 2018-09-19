import UIKit

class SpyAppViewController: UIViewController {

    @IBOutlet weak var input: UITextField!
    @IBOutlet weak var secret: UITextField!
    @IBOutlet weak var output: UILabel!

    let factory = CipherFactory()
    var cipher: Cipher?

    var plaintext: String {
        if let text = input.text {
            return text
        } else {
            return ""
        }
    }

    var secretText: String {
        if let text = secret.text {
            return text
        } else {
            return ""
        }
    }
    
    var outputText: String {
        if let text = output.text {
            return text
        } else {
            return ""
        }
    }
    
    @IBAction func encodeButtonPressed(_ sender: UIButton) {
        guard let cipher = self.cipher else {
            output.text = "No cipher selected"
            return
        }
        if let encoded = cipher.encode(plaintext, secret: secretText) {
            output.text = encoded
        } else {
            output.text = "Error encoding"
        }
    }

    @IBAction func cipherButtonPressed(_ sender: UIButton) {
        guard
            let buttonLable = sender.titleLabel,
            let buttonText = buttonLable.text
        else {
            output.text = "No button or no button text"
            return
        }
        cipher = factory.cipher(for: buttonText)
    }
  
    @IBAction func decodeButtonPressed(_ sender: Any) {
        if let decoded = cipher?.decrypt(outputtext: outputText, secret: secretText){
            output.text = decoded
        } else {
        output.text = "Nothing to decode"
    }
}
    @IBAction func AlphaNumericalButtonPressed(_ sender: UIButton) {
        guard
            let buttonLabel = sender.titleLabel,
            let buttonText = buttonLabel.text
        else {
            output.text = "No button or no button text"
            return
        }
        cipher = factory.cipher(for: buttonText)
    }
    
    @IBAction func mirrorButtonPressed(_ sender: UIButton) {
        guard
            let buttonLabel = sender.titleLabel,
            let buttonText = buttonLabel.text
        else {
            output.text = "No button or no button text"
            return
        }
        cipher = factory.cipher(for: buttonText)
    }

    @IBAction func PigLatinButtonPressed(_ sender: UIButton) {
        guard
            let buttonLable = sender.titleLabel,
            let buttonText = buttonLable.text
        else {
            output.text = "No button or button text"
            return
        }
        cipher = factory.cipher(for: buttonText)
        
        
        
    }
    
    
}
