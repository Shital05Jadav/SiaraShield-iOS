//
//  verificationPopUpView.swift
//  SiaraShield-iOS
//
//  Created by ShitalJadav on 20/03/23.
//

import UIKit

 class verificationPopUpView: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var protectByLabel: UILabel!
    @IBOutlet weak var privacyPolicyLabel: UILabel!
    @IBOutlet weak var moreBtn: UIButton!
    @IBOutlet weak var protectedByBtn: UIButton!
    @IBOutlet weak var txtSecretcode: UITextField!
    @IBOutlet weak var lettrsview: UIImageView!
    @IBOutlet weak var txtLanguage: DropDown!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var eyeIconButton: UIButton!
    
    
    // MARK: Variables
    var objGenerateCaptcha = GenerateCaptchaViewModel()
    var objCaptchaVerify = CaptchaVerifyViewModel()
    var isCaptchaShowing : Bool = false
    
     override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        mainView.layer.cornerRadius = 10
        mainView.layer.shadowColor = UIColor.lightGray.cgColor
        mainView.layer.shadowOpacity = 1
        mainView.layer.shadowOffset = CGSize.zero
        mainView.layer.shadowRadius = 5
        txtLanguage.layer.cornerRadius = 10
        txtSecretcode.layer.shadowColor = UIColor.lightGray.cgColor
        txtSecretcode.layer.shadowOpacity = 1
        txtSecretcode.layer.shadowOffset = CGSize.zero
        txtSecretcode.layer.shadowRadius = 5
        lettrsview.layer.borderWidth = 1
        lettrsview.layer.borderColor = UIColor.lightGray.cgColor
        txtSecretcode.delegate = self
        txtSecretcode.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: txtSecretcode.frame.height))
        txtSecretcode.leftViewMode = .always
        
        self.moreBtn.setTitle("", for: .normal)
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(self.onTapPrivacyPolicy))
        privacyPolicyLabel.isUserInteractionEnabled = true
        privacyPolicyLabel.addGestureRecognizer(tap1)
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(self.onTapProtectedBy))
        protectByLabel.addGestureRecognizer(tap2)
        protectByLabel.isUserInteractionEnabled = true
    }
    
     override func viewDidLoad() {
        super.viewDidLoad()
         ProgressHUD.show()
         objGenerateCaptcha.generateCaptchaAPICall()  { isSuccess in
             ProgressHUD.dismiss()
             if isSuccess{
                 if captcha != "" {
                     if let imageURL = UIImage.gif(url: captcha) {
                         DispatchQueue.main.async {
                             self.lettrsview.image = imageURL
                         }
                     } else {
                         self.presentAlert(withTitle: "Captcha", message: "Wrong Captcha Url found!")
                     }
                     
                 } else {
                     self.presentAlert(withTitle: "Captcha", message: "Captcha not found!")
                 }
             } else {
                 self.presentAlert(withTitle: "Error", message: "Captcha not found!!")
             }
         }
       
       
    }
    
    // MARK: Functions
    @objc func onTapPrivacyPolicy(sender:UITapGestureRecognizer) {
        guard let url = URL(string: "https://www.cybersiara.com/privacy") else {
            return
        }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @objc func onTapProtectedBy(sender:UITapGestureRecognizer) {
        guard let url = URL(string: "https://www.cybersiara.com/terms") else {
            return
        }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    // MARK: Actions
    @IBAction func OnTapMoreOptions(_ sender: UIButton) {
        McPicker.show(data: [["Accessibility", "Report Image", "Report Bug"]]) {  [weak self] (selections: [Int : String]) -> Void in
            if let name = selections[0] {
                if name == "Accessibility" {
                    guard let url = URL(string: "https://www.cybersiara.com/accessibility") else {
                        return
                    }
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                } else if name == "Report Image" {
                    guard let url = URL(string: "https://mycybersiara.com/ReportBug?rt=b&d=https://staging.mycybersiara.com/Login/TestingPage") else {
                        return
                    }
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                } else if name == "Report Bug" {
                    guard let url = URL(string: "https://mycybersiara.com/ReportBug?rt=b&d=https://staging.mycybersiara.com/Login/TestingPage") else {
                        return
                    }
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }
            }
        }
    }
    
    @IBAction func onTapRefresh(_ sender: UIButton) {
        ProgressHUD.show()
        objGenerateCaptcha.generateCaptchaAPICall()  { isSuccess in
                ProgressHUD.dismiss()
                if isSuccess{
                    if captcha != "" {
                        if let imageURL = UIImage.gif(url: captcha) {
                            DispatchQueue.main.async {
                            self.lettrsview.image = imageURL
                            }
                        } else {
                            self.presentAlert(withTitle: "Captcha", message: "Wrong Captcha Url found!")
                        }
                    } else {
                        self.presentAlert(withTitle: "Error", message: "Captcha not found!")
                    }
                } else {
                    self.presentAlert(withTitle: "Error", message: "Captcha not found!!")
                }
        }
        
    }
    @IBAction func onTapClose(_ sender: UIButton) {
        self.dismiss(animated: true, completion: {
            NotificationCenter.default.post(name: Notification.Name("VerifyPopUp"), object: false)
        })
    }
    
    @IBAction func OnTapHideShowcaptchaCode(_ sender: UIButton) {
        if self.isCaptchaShowing == false { // Not Showing
            self.isCaptchaShowing = true
            self.txtSecretcode.isSecureTextEntry = false //Show
            if let image = ImageProvider.image(named: "password-visibility-icon") {
                self.eyeIconButton.setImage(image, for: .normal)
            }
        }
        else if self.isCaptchaShowing == true { // Showing
            self.isCaptchaShowing = false
            self.txtSecretcode.isSecureTextEntry = true //hide
            if let image = ImageProvider.image(named: "password-hide-icon") {
                self.eyeIconButton.setImage(image, for: .normal)
            }
        }
    }
    
}

extension verificationPopUpView : UITextFieldDelegate {
     func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 4
        let currentString = (textField.text ?? "") as NSString
        let newString = currentString.replacingCharacters(in: range, with: string)
        
        return newString.count <= maxLength
    }
    
     func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("return pressed")
        textField.resignFirstResponder()
        if captcha != "" {
            ProgressHUD.show()
            objCaptchaVerify.captchaVerifyAPICall(userCaptcha: self.txtSecretcode.text ?? "") { isSuccess in
                DispatchQueue.main.async {
                    ProgressHUD.dismiss()
                    if isSuccess{
                        self.dismiss(animated: true, completion: {
                            NotificationCenter.default.post(name: Notification.Name("VerifyPopUp"), object: true)
                        })
                    } else {
                        self.presentAlert(withTitle: "Error", message: "Wrong Captcha, Please enter again!")
                    }
                }
            }
            
        } else {
            self.presentAlert(withTitle: "Error", message: "Captcha not found!!")
        }
        return false
    }
    
    @objc func textFieldDidChange(_ textField : UITextField) {
        
        if textField == self.txtSecretcode {
            if self.txtSecretcode.text!.count > 0 {
                self.eyeIconButton.isHidden = false
            }
            else if self.txtSecretcode.text!.count < 1 {
                self.eyeIconButton.isHidden = true
            }
        }
    }
}
