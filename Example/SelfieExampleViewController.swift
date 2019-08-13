import UIKit
import MobileCoreServices
import CoreGraphics
import AVKit
import SelfieSDK


class SelfieExampleViewController: UIViewController, LiveViewControllerDelegate {
  
    
  
    @IBOutlet weak var transactionView: UIView!
    @IBOutlet weak var onboardingView: UIView!

    
    let apiKey = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VybmFtZSI6ImFuZGlhdGVzdCJ9.lUlVdh2tTL2ck_q8PGqct35UzIBw9mSP1cG1nqFk2RE"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var onboarded = false
        if let value = UserDefaults.standard.value(forKey: "onboarded") {
            onboarded = (value as? Bool)!
        }
        if (onboarded == true){
            self.transactionView.isHidden = false
            self.onboardingView.isHidden = true
        } else {
            self.transactionView.isHidden = true
        }
    }
    
    //Change
    func resultAlert(_ message: String?){
        let alert = UIAlertController(title: "Andia", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func resultLiveValidation(_ isMatch: Bool?, _ message: String?) {
        resultAlert(message)
    }
    
    func resultDocumentOnboarding(_ success: Bool?, _ message: String?,_ userId: String?, _ ocr: String?) {
        if (success!){
            UserDefaults.standard.set(userId, forKey: "userId")
            UserDefaults.standard.set(true, forKey: "onboarded")
            UserDefaults.standard.synchronize()
            self.transactionView.isHidden = false
            self.onboardingView.isHidden = true
            DispatchQueue.main.async {
                self.resultAlert("Welcome")
            }
            
        } else {
            DispatchQueue.main.async {
                self.resultAlert(message)
            }
        }
    }
    
    func resultDocumentOcr(_ success: Bool?, _ nextController: UIViewController?) {
        if (success!){
            present(nextController!, animated: true, completion: nil)
        }
    }
    
    func resultSelfieOnboarding(_ success: Bool?, _ message: String?,_ userId: String?) {
        if (success!){
            UserDefaults.standard.set(userId, forKey: "userId")
            UserDefaults.standard.set(true, forKey: "onboarded")
            UserDefaults.standard.synchronize()
            self.transactionView.isHidden = false
            self.onboardingView.isHidden = true
            DispatchQueue.main.async {
                self.resultAlert("Welcome")
            }
        } else {
            DispatchQueue.main.async {
                DispatchQueue.main.async {
                    self.resultAlert(message)
                }
            }
        }
    }
    
    
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
    
    
}
