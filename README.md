# mobile_biometric_ios

Andia InApp validation SDK for iOS

Selfie Validations Framework, Liveness detection, Face Recognition, Prevent Identity Fraud

# Requirements
* iOS 11.0
* XCode 10

# Copy the file Selfie.framework into your iOS project in XCode

# Import the Framework in your ViewController

![alt text](https://github.com/josebetomex/mobile_biometric_ios/blob/master/Screen%20Shot%202019-03-04%20at%2013.49.28.png "Selfie")
 ![alt text](https://github.com/josebetomex/mobile_biometric_ios/blob/master/Screen%20Shot%202019-03-04%20at%2013.49.38.png "Validation")


```swift
import SelfieSDK

// Implement LiveViewControllerDelegate protocol.
class myViewController: UIViewController, LiveViewControllerDelegate {
  //View Controller Code
  
  
  @IBAction
  func doOnboarding() {
    let selfie = SelfieValidator()
    let apiKey = "ExampleAPIKEY" //Get your own API KEY in Andia site.
    let viewController =  selfie.doOnboarding(apiKey: apiKey, delegateController: self)
    present(viewController, animated: true, completion: nil)
  }
  
  @IBAction
  func doValidation() {
        //Example of Validation call
        let selfie = SelfieValidator()
        let apiKey = "ExampleAPIKEY" //Get your own API KEY in Andia site.
        let viewController = selfie.doValidation(userId: userId!, apiKey: apiKey, delegateController: self)
        present(viewController, animated: true, completion: nil)
  }
  
  //Callbacks
  //Validataion Callback
  func resultLiveValidation(_ isMatch: Bool?, _ message: String?){
        
  }
  
  //OnBoarding Callback
  //userId is the new identifier for this selfie customer
  func resultOnboarding(_ success: Bool?, _ message: String?,_ userId: String?) {
       
  }
  
}

```

