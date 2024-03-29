//
//  SlidingView.swift
//  SiaraShield-iOS
//
//  Created by ShitalJadav on 21/03/23.
//

import UIKit

public protocol SlidingViewDelegate {
    func verifiedtoken()
}

public class SlidingView: UIView {
    
    // MARK: Outlets
    @IBOutlet weak var stackview: UIStackView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var slidetoverifyLabel: UILabel!
    @IBOutlet weak var hiddenuserLabel: UILabel!
    @IBOutlet weak var vierifiedLabel: UILabel!
    @IBOutlet weak var gradiantView: UIView!
    @IBOutlet weak var verifygifImg: UIImageView!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var sliderView: UIView!
    @IBOutlet weak var mainView: UIView!
    
    // MARK: Variables
    var objfirstViewModel = FirstViewModel()
    var objSubmitCaptcha = submitCaptchaViewModel()
    var objVerifyToken = ValidateTokenViewModel()
    fileprivate weak var parentController: UIViewController?
    public var delegate: SlidingViewDelegate?
    
    @IBInspectable public var publicKeyValue: String = "" {
        didSet {
            masterUrlId = publicKeyValue
        }
    }
    
    @IBInspectable public var privateKeyValue: String = "" {
        didSet {
            privateKey = privateKeyValue
        }
    }
    
    @IBInspectable public var requestUrlValue: String = "" {
        didSet {
            requestUrl = requestUrlValue
        }
    }
    
    init(frame: CGRect,VC: UIViewController) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        let bundle = Bundle(for: self.classForCoder)
        let nib = UINib(nibName: "SlidingView", bundle: bundle)
        nib.instantiate(withOwner: self, options: nil)
        stackview.bounds = self.bounds
        addSubview(stackview)
        stackview.bounds = self.bounds
        stackview.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        mainView.layer.cornerRadius = 10
        sliderView.layer.cornerRadius = 20
        gradiantView.layer.cornerRadius = 20
        submitButton.layer.cornerRadius = 5
        mainView.layer.shadowColor = UIColor.lightGray.cgColor
        mainView.layer.shadowOpacity = 1
        mainView.layer.shadowOffset = CGSize.zero
        mainView.layer.shadowRadius = 7
        let gradientLayer:CAGradientLayer = CAGradientLayer()
        gradientLayer.frame = self.gradiantView.bounds
        gradientLayer.colors =
        [UIColor.white.cgColor,UIColor.lightGray.withAlphaComponent(1).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        self.gradiantView.layer.insertSublayer(gradientLayer, at: 1)
        self.gradiantView.clipsToBounds = true
        self.slider.setThumbImage(ImageProvider.image(named: "rightslider-icon"), for: .normal)
        if let imageURL = UIImage.gif(url: "https://user-images.githubusercontent.com/128694120/230565042-0e450ddb-5a52-4b83-b851-abcf5b649750.gif") {
            self.verifygifImg.image = imageURL
        } else {
            print("wrong url")
        }
        verifygifImg.isHidden = true
        vierifiedLabel.isHidden = true
        submitButton.isHidden = true
        submitButton.isUserInteractionEnabled = false
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("VerifyPopUp"), object: nil)
    }
    
    public func getvalue(vc:UIViewController) {
        ProgressHUD.show()
        self.mainView.isUserInteractionEnabled = false
        parentController = vc
        if masterUrlId != "" && requestUrl != "" {
            slider.isUserInteractionEnabled = true
            objfirstViewModel.firstAPICall() { isSuccess in
                DispatchQueue.main.async {
                    self.mainView.isUserInteractionEnabled = true
                    ProgressHUD.dismiss()
                }
            }
        } else {
            self.mainView.isUserInteractionEnabled = true
            ProgressHUD.dismiss()
            self.parentController?.presentAlert(withTitle: "Error", message: "masterUrlId & requestId values are missing")
        }
    }
    
    // MARK: Functions
    @objc func methodOfReceivedNotification(notification: Notification) {
        ProgressHUD.show()
        if let obj = notification.object as? Bool {
            if obj == true {
                self.verifygifImg.isHidden = false
                self.sliderView.backgroundColor = UIColor(hexString: "#1B62A9")
                if let imageURL = UIImage.gif(url: "https://user-images.githubusercontent.com/128694120/230565042-0e450ddb-5a52-4b83-b851-abcf5b649750.gif") {
                    self.verifygifImg.image = imageURL
                } else {
                    print("wrong url")
                }
                self.vierifiedLabel.isHidden = false
                self.slidetoverifyLabel.isHidden = true
                self.hiddenuserLabel.isHidden = true
                self.slider.setThumbImage(UIImage(), for: .normal)
                self.submitButton.isHidden = false
                self.submitButton.isUserInteractionEnabled = true
                ProgressHUD.dismiss()
                DispatchQueue.main.asyncAfter(deadline: .now() + 30.0) {
                    self.slider.setValue(0.0, animated: true)
                    self.sliderView.backgroundColor = UIColor.clear
                    self.verifygifImg.isHidden = true
                    self.verifygifImg.isHidden = true
                    self.vierifiedLabel.isHidden = true
                    self.slidetoverifyLabel.isHidden = false
                    self.hiddenuserLabel.isHidden = false
                    self.submitButton.isHidden = true
                    self.slider.setThumbImage(ImageProvider.image(named: "rightslider-icon"), for: .normal)
                    self.submitButton.isUserInteractionEnabled = false
                }
            } else {
                self.slider.setValue(0.0, animated: true)
                self.sliderView.backgroundColor = UIColor.clear
                self.verifygifImg.isHidden = true
                self.verifygifImg.isHidden = true
                self.vierifiedLabel.isHidden = true
                self.slidetoverifyLabel.isHidden = false
                self.hiddenuserLabel.isHidden = false
                self.submitButton.isHidden = true
                self.slider.setThumbImage(ImageProvider.image(named: "rightslider-icon"), for: .normal)
                self.submitButton.isUserInteractionEnabled = false
                ProgressHUD.dismiss()
            }
        }
    }
    
    func submitCaptchaAPICall() {
        ProgressHUD.show()
        self.mainView.isUserInteractionEnabled = false
        self.slider.isUserInteractionEnabled = false
        self.objSubmitCaptcha.submitCaptchaAPICall()  { isSuccess in
            if isSuccess{
                DispatchQueue.main.async {
                    self.mainView.isUserInteractionEnabled = true
                    self.slider.isUserInteractionEnabled = true
                    ProgressHUD.dismiss()
                    self.verifygifImg.isHidden = false
                    self.sliderView.backgroundColor = UIColor(hexString: "#1B62A9")
                    if let imageURL = UIImage.gif(url: "https://user-images.githubusercontent.com/128694120/230565042-0e450ddb-5a52-4b83-b851-abcf5b649750.gif") {
                        self.verifygifImg.image = imageURL
                    } else {
                        print("wrong url")
                    }
                    self.vierifiedLabel.isHidden = false
                    self.slidetoverifyLabel.isHidden = true
                    self.hiddenuserLabel.isHidden = true
                    self.slider.setThumbImage(UIImage(), for: .normal)
                    self.submitButton.isHidden = false
                    self.submitButton.isUserInteractionEnabled = true
                }
            } else {
                DispatchQueue.main.async {
                    self.mainView.isUserInteractionEnabled = true
                    self.slider.isUserInteractionEnabled = true
                    if requestId != "" {
                        ProgressHUD.dismiss()
                        let vc = verificationPopUpView.init(nibName: "verificationPopUpView", bundle: Bundle(for: self.classForCoder))
                        vc.modalPresentationStyle = .overFullScreen
                        self.parentController?.present(vc, animated: true, completion: nil)
                    } else {
                        ProgressHUD.dismiss()
                        self.slider.setValue(0.0, animated: true)
                        self.parentController?.presentAlert(withTitle: "Error", message: "Request Id and Vister Id not found!!")
                    }
                }
            }
        }
    }
    
    // MARK: Actions
    @IBAction func OnTapSubmitButton(_ sender: UIButton) {
        ProgressHUD.show()
        self.objVerifyToken.validatetokenAPICall() { isSuccess in
            DispatchQueue.main.async {
                ProgressHUD.dismiss()
                if isSuccess {
                    self.slider.setValue(0.0, animated: true)
                    self.sliderView.backgroundColor = UIColor.clear
                    self.verifygifImg.isHidden = true
                    self.verifygifImg.isHidden = true
                    self.vierifiedLabel.isHidden = true
                    self.slidetoverifyLabel.isHidden = false
                    self.hiddenuserLabel.isHidden = false
                    self.submitButton.isHidden = true
                    self.slider.setThumbImage(ImageProvider.image(named: "rightslider-icon"), for: .normal)
                    self.submitButton.isUserInteractionEnabled = false
                    self.delegate?.verifiedtoken()
                } else {
                    self.slider.setValue(0.0, animated: true)
                    self.sliderView.backgroundColor = UIColor.clear
                    self.verifygifImg.isHidden = true
                    self.verifygifImg.isHidden = true
                    self.vierifiedLabel.isHidden = true
                    self.slidetoverifyLabel.isHidden = false
                    self.hiddenuserLabel.isHidden = false
                    self.submitButton.isHidden = true
                    self.slider.setThumbImage(ImageProvider.image(named: "rightslider-icon"), for: .normal)
                    self.submitButton.isUserInteractionEnabled = false
                    self.parentController?.presentAlert(withTitle: "Error", message: "Token validation failed.")
                }
            }
        }
    }
    
    @IBAction func slideChangeValue(_ sender: UISlider) {
        if masterUrlId != "" && requestUrl != "" {
            let value = sender.value
            if value == slider.maximumValue {
                slider.isContinuous = false
                submitCaptchaAPICall()
            }
        } else {
            self.parentController?.presentAlert(withTitle: "Error", message: "masterUrlId & requestId values missing, Please add Proper Values")
        }
    }
}

