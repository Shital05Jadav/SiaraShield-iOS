//
//  CaptchaVerifyViewModel.swift
//  SiaraShield_iOS
//
//  Created by ShitalJadav on 21/03/23.
//

import UIKit

class CaptchaVerifyViewModel: NSObject {
    
    var captchaVerifyReq = captchVerifyRequest()
    
    func captchaVerifyAPICall(userCaptcha: String, completion: @escaping( _ ifResult: Bool) -> Void) {
        let url = EndPoint.shared.captchaVerifyURL()
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = HTTPMethod.POST.rawValue
        captchaVerifyReq.masterUrlId = masterUrlId
        captchaVerifyReq.deviceIp = deviceIp[1]
        captchaVerifyReq.deviceType = deviceType
        captchaVerifyReq.deviceName = deviceName
        captchaVerifyReq.userCaptcha = userCaptcha
        captchaVerifyReq.byPass = "Netural"
        captchaVerifyReq.browserIdentity = browserIdentity
        captchaVerifyReq.timespent = "24"
        captchaVerifyReq.strProtocol = protocol_Value
        captchaVerifyReq.flag = "1"
        captchaVerifyReq.second = "60"
        captchaVerifyReq.requestID = requestId
        captchaVerifyReq.fillupsecond = "60"
        
        guard let jsonObj = try captchaVerifyReq.dictionary else {
            return
        }
        if (!JSONSerialization.isValidJSONObject(jsonObj)) {
            print("is not a valid json object")
            return
        }
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: jsonObj, options: []) else {
            return
        }
        request.httpBody = httpBody
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            guard data != nil else {
                print("data is nil")
                return
            }
            do {
                if let resData = data {
                    if let json = (try? JSONSerialization.jsonObject(with: resData, options: [])) as? Dictionary<String,AnyObject>
                    {
                        if let msg = json["Message"] as? String {
                            if msg == "Success" || msg == "success" {
                                if let tokenVal = json["data"] as? String {
                                    token = tokenVal
                                }
                                completion(true)
                            } else if msg == "fail" || msg == "Fail" {
                                completion(false)
                            } else if msg == "" {
                                completion(true)
                            }else {
                                completion(false)
                            }
                        } else {
                            completion(false)
                        }
                    }
                    else {
                        completion(false)
                    }
                    
                } else {
                    print("No Data Found")
                    completion(false)
                }
            }
            
        }.resume()
    }
}
