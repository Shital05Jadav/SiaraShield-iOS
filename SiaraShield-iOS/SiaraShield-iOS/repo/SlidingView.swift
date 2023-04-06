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
        slider.setThumbImage(UIImage(named: "rightslider-icon"), for: .normal)
        verifygifImg.loadGif(name: "verifiedGif")
        verifygifImg.isHidden = true
        vierifiedLabel.isHidden = true
        submitButton.isHidden = true
        submitButton.isUserInteractionEnabled = false
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("VerifyPopUp"), object: nil)
    }
    
   public func getvalue(vc:UIViewController) {
        parentController = vc
        if masterUrlId != "" && requestUrl != "" {
            slider.isUserInteractionEnabled = true
            objfirstViewModel.firstAPICall()
        } else {
            self.parentController?.presentAlert(withTitle: "Error", message: "masterUrlId & requestId values missing")
        }
    }
    
    // MARK: Functions
    @objc func methodOfReceivedNotification(notification: Notification) {
        if let obj = notification.object as? Bool {
            if obj == true {
                self.verifygifImg.isHidden = false
                self.sliderView.backgroundColor = UIColor(hexString: "#1B62A9")
                self.verifygifImg.loadGif(name: "verifiedGif")
                self.vierifiedLabel.isHidden = false
                self.slidetoverifyLabel.isHidden = true
                self.hiddenuserLabel.isHidden = true
                self.slider.setThumbImage(UIImage(), for: .normal)
                self.submitButton.isHidden = false
                self.submitButton.isUserInteractionEnabled = true
            } else {
                self.slider.setValue(0.0, animated: true)
                self.sliderView.backgroundColor = UIColor.clear
                self.verifygifImg.isHidden = true
                self.verifygifImg.isHidden = true
                self.vierifiedLabel.isHidden = true
                self.slidetoverifyLabel.isHidden = false
                self.hiddenuserLabel.isHidden = false
                self.submitButton.isHidden = true
                self.slider.setThumbImage(UIImage(named: "rightslider-icon"), for: .normal)
                self.submitButton.isUserInteractionEnabled = false
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
                    self.slider.setThumbImage(UIImage(named: "rightslider-icon"), for: .normal)
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
                ProgressHUD.show()
                self.objSubmitCaptcha.submitCaptchaAPICall()  { isSuccess in
                    if isSuccess{
                        DispatchQueue.main.async {
                            ProgressHUD.dismiss()
                            self.verifygifImg.isHidden = false
                            self.sliderView.backgroundColor = UIColor(hexString: "#1B62A9")
                            self.verifygifImg.loadGif(name: "verifiedGif")
                            self.vierifiedLabel.isHidden = false
                            self.slidetoverifyLabel.isHidden = true
                            self.hiddenuserLabel.isHidden = true
                            self.slider.setThumbImage(UIImage(), for: .normal)
                            self.submitButton.isHidden = false
                            self.submitButton.isUserInteractionEnabled = true
                        }
                    } else {
                        DispatchQueue.main.async {
                            ProgressHUD.dismiss()
                            self.slider.setValue(0.0, animated: true)
                            if requestId != "" {
                                let vc = verificationPopUpView()
                                vc.modalPresentationStyle = .overFullScreen
                                self.parentController?.present(vc, animated: true, completion: nil)
                            } else {
                                self.parentController?.presentAlert(withTitle: "Error", message: "Request Id and Vister Id not found!!")
                            }
                        }
                    }
                }
            }
        } else {
            self.parentController?.presentAlert(withTitle: "Error", message: "masterUrlId & requestId values missing, Please add Proper Values")
        }
    }
    
}

