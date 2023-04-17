//
//  submitCaptchaViewModel.swift
//  SiaraShield_iOS
//
//  Created by ShitalJadav on 21/03/23.
//

import UIKit
import Foundation

class submitCaptchaViewModel: NSObject {
    
    var submitCaptchaReq = submitCaptchaRequest()
    
    func submitCaptchaAPICall(completion: @escaping( _ ifResult: Bool) -> Void) {
        let url = EndPoint.shared.submitCaptchaURL()
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = HTTPMethod.POST.rawValue
        submitCaptchaReq.masterUrl = masterUrlId
        submitCaptchaReq.deviceIp = deviceIp[1]
        submitCaptchaReq.deviceName = deviceName
        submitCaptchaReq.browserIdentity = browserIdentity
        submitCaptchaReq.strProtocol = protocol_Value
        submitCaptchaReq.second = "5"
        if requestId != "" {
            submitCaptchaReq.requestID = requestId
        } else {
            completion(false)
        }
        if visiter_Id != "" {
            submitCaptchaReq.visiterId = visiter_Id
        } else {
            completion(false)
        }
        debugPrint(submitCaptchaReq)
        guard let jsonObj = submitCaptchaReq.dictionary else {
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
                        debugPrint(json)
                        let msg = json["Message"] as? String
                        if msg == "Success" || msg == "success" {
                            completion(true)
                        } else if msg == "fail" || msg == "Fail" {
                            completion(false)
                        } else {
                            completion(false)
                        }
                    }
                } else {
                    print("No Data Found")
                    completion(false)
                }
            }
            
            
        }.resume()
    }
    
}

