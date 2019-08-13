# mobile_biometric_ios

Andia InApp validation SDK for iOS

Selfie Validations Framework, Liveness detection, Face Recognition, Prevent Identity Fraud

# Requirements
* iOS 11.0
* XCode 10

# Copy the file Selfie.framework into your iOS project in XCode

# Import the Framework in your ViewController

![alt text](https://github.com/josebetomex/mobile_biometric_ios/blob/master/andia.gif "Selfie")

```swift
import SelfieSDK

// Implement LiveViewControllerDelegate protocol.
class myViewController: UIViewController, LiveViewControllerDelegate {
  //View Controller Code
  
   @IBAction
    func selfieOnboarding() {
        let selfie = SelfieValidator()
        let viewController =  selfie.doSelfieOnboarding(apiKey: apiKey, delegateController: self)
        present(viewController, animated: true, completion: nil)
    }
    
    @IBAction
    func documentOnboarding() {
        let selfie = SelfieValidator()
        let viewController =  selfie.doDocumentOnboarding(apiKey: apiKey, delegateController: self)
        present(viewController, animated: true, completion: nil)
    }
    
    @IBAction
    func startLiveValidation() {
        let userId = UserDefaults.standard.string(forKey: "userId")
        let selfie = SelfieValidator()
        let viewController = selfie.doValidation(userId: userId!, apiKey: apiKey, isDocumentVsSelfie: false, delegateController: self)
        
        present(viewController, animated: true, completion: nil)
    }
  

  //Callbacks
    func resultLiveValidation(_ isMatch: Bool?, _ message: String?) {
    
    }
    
    func resultDocumentOnboarding(_ success: Bool?, _ message: String?,_ userId: String?, _ ocr: String?) {
        
    }
    
    func resultDocumentOcr(_ success: Bool?, _ nextController: UIViewController?) {
         
    }
    
    func resultSelfieOnboarding(_ success: Bool?, _ message: String?,_ userId: String?) {
         
    }
  
}

```

