import UIKit
import MobileCoreServices
import CoreGraphics
import AVKit
import OnboardingKit

final class DataModel: OnboardingViewDataSource, OnboardingViewDelegate {
    func numberOfPages() -> Int {
        return 4
    }
    
    public var didShow: ((Int) -> Void)?
    public var willShow: ((Int) -> Void)?
    
    func onboardingView(_ onboardingView: OnboardingView, configurationForPage page: Int) -> OnboardingConfiguration {
        return OnboardingConfiguration(
            image: UIImage(),
            itemImage: UIImage(named: "icon\(page).png")!,
            pageTitle: "",
            pageDescription: "",
            backgroundImage : UIImage(named: "onboard\(page).png"),
            topBackgroundImage: nil, // your image here
            bottomBackgroundImage: nil // your image here
        )
    }
    public func onboardingView(_ onboardingView: OnboardingView, didSelectPage page: Int) {
        print("Did select pge \(page)")
        didShow?(page)
    }
    
    public func onboardingView(_ onboardingView: OnboardingView, willSelectPage page: Int) {
        print("Will select page \(page)")
        willShow?(page)
    }
}



class IntroViewController: UIViewController {
    
    @IBOutlet weak var onboardingView: OnboardingView!
    @IBOutlet weak var nextButton: UIButton!

    private let model = DataModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        onboardingView.dataSource = model
        onboardingView.delegate = model
        
        model.willShow = { page in
            if page == 3 {
                UserDefaults.standard.set(false, forKey: "firstTime")
                UserDefaults.standard.synchronize()
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    
}

