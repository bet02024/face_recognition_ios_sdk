import UIKit
import MobileCoreServices
import CoreGraphics
import AVKit
import SelfieSDK  


class FirstViewController: UIViewController, LiveViewControllerDelegate {
 
    @IBOutlet weak var transactionView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var onboarded = false
        if let value = UserDefaults.standard.value(forKey: "onboarded") {
            onboarded = (value as? Bool)!
        }
        if (onboarded == true){
            self.transactionView.isHidden = false
        } else {
            self.transactionView.isHidden = true
        }
    }
    

    override func viewDidAppear(_ animated: Bool) {
        var firstTime = true
        if let value = UserDefaults.standard.value(forKey: "firstTime") {
            firstTime = (value as? Bool)!
        }
        if (firstTime){
            let liveValidation = self.storyboard?.instantiateViewController(withIdentifier: "IntroViewController") as! IntroViewController
            self.present(liveValidation, animated: true, completion: nil)
        }
    }
    
    
    func resultLiveValidation(_ isMatch: Bool?, _ message: String?){
        let alert = UIAlertController(title: "Andia", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func resultOnboarding(_ success: Bool?, _ message: String?,_ userId: String?) {
        if (success!){
            UserDefaults.standard.set(userId, forKey: "userId")
            UserDefaults.standard.set(true, forKey: "onboarded")
            UserDefaults.standard.synchronize()
            self.transactionView.isHidden = false
          
        } else {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Andia", message: message, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction
    func startLiveValidation() {
        let onboarded = UserDefaults.standard.bool(forKey: "onboarded")
        let userId = UserDefaults.standard.string(forKey: "userId")
        let selfie = SelfieValidator()
        //#####################################################################
        //#####################################################################
        let apiKey = "YOUR_API_KEY"
        //#####################################################################
        //#####################################################################
        if (onboarded  && (userId?.count)! > 0 ){
            let viewController = selfie.doValidation(userId: userId!, apiKey: apiKey, delegateController: self)
            present(viewController, animated: true, completion: nil)
            
        } else {
            let viewController =  selfie.doOnboarding(apiKey: apiKey, delegateController: self)
            present(viewController, animated: true, completion: nil)

        }
    }
}
