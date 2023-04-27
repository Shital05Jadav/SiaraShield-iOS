//
//  CaptchaVerifyViewModel.swift
//  SiaraShield_iOS
//
//  Created by ShitalJadav on 21/03/23.
//

import UIKit

class CaptchaVerifyViewModel: NSObject {
    
    var captchaVerifyReq = captchVerifyRequest()
    
    func captchaVerifyAPICall(userCaptcha: String, fillupsecond: String, completion: @escaping( _ ifResult: Bool) -> Void) {
        let url = EndPoint.shared.captchaVerifyURL()
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = HTTPMethod.POST.rawValue
    
        let jsonObj:Dictionary<String, Any> = [
        "MasterUrl":masterUrlId,
        "DeviceIp":deviceIp[1],
        "DeviceType":deviceType,
        "DeviceName":deviceName,
        "UserCaptcha":userCaptcha,
        "ByPass":"Netural",
        "BrowserIdentity":browserIdentity,
        "Timespent":"5",
        "Protocol":protocol_Value,
        "Flag":"1",
        "second":"5",
        "RequestID":requestId,
        "VisiterId":visiter_Id,
        "fillupsecond":fillupsecond
        ]
        debugPrint(jsonObj)
        if (!JSONSerialization.isValidJSONObject(jsonObj)) {
            print("is not a valid json object")
            return
        }
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: jsonObj, options: []) else {
            return
        }
        request.httpBody = httpBody
        let header = [
                "Content-Type" : "application/json"
            ]
        request.allHTTPHeaderFields = header
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
                        if let msg = json["Message"] as? String {
                            if msg == "Success" || msg == "success" {
                                if let tokenVal = json["data"] as? String {
                                    token = tokenVal
                                }
                                completion(true)
                            } else if msg == "fail" || msg == "Fail" {
                                completion(false)
                            } else if msg == "" {
                                completion(false)
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
