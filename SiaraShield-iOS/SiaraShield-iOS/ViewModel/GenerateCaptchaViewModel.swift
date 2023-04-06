//
//  GenerateCaptchaViewModel.swift
//  SiaraShield_iOS
//
//  Created by ShitalJadav on 21/03/23.
//

import UIKit

class GenerateCaptchaViewModel: NSObject {
    
    var generateCaptchaReq = generateCaptchaRequest()
    
    func generateCaptchaAPICall(completion: @escaping( _ ifResult: Bool) -> Void) {
        let url = EndPoint.shared.generateCaptchaURL()
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = HTTPMethod.POST.rawValue
        generateCaptchaReq.masterUrlId = masterUrlId
        generateCaptchaReq.requestUrl = requestUrl
        generateCaptchaReq.browserIdentity = browserIdentity
        generateCaptchaReq.deviceIp = deviceIp[1]
        generateCaptchaReq.deviceType = deviceType
        generateCaptchaReq.deviceBrowser = deviceBrowser
        generateCaptchaReq.deviceName = deviceName
        generateCaptchaReq.deviceHeight = deviceHeight
        generateCaptchaReq.deviceWidth = deviceWidth
        if visiter_Id != "" {
            generateCaptchaReq.visiterId = visiter_Id
        } else {
            completion(false)
        }
        

        guard let jsonObj = generateCaptchaReq.dictionary else {
            return
        }
//        let jsonObj:Dictionary<String, Any> = [
//        "MasterUrlId":masterUrlId,
//        "RequestUrl":requestUrl,
//        "BrowserIdentity":browserIdentity,
//        "DeviceIp":deviceIp[1],
//        "DeviceType":deviceType,
//        "DeviceBrowser":deviceBrowser,
//        "DeviceName":deviceName,
//        "DeviceHeight":deviceHeight,
//        "DeviceWidth":deviceWidth,
//        "VisiterId": visiter_Id
//            ]
        
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
                completion(false)
                return
            }
            do {
              
                if let resData = data {
                    if let json = (try? JSONSerialization.jsonObject(with: resData, options: [])) as? Dictionary<String,AnyObject>
                                       {
                        debugPrint(json)
                        if let msg = json["Message"] as? String {
                            if msg == "Success" || msg == "success" {
                                if let reqId = json["RequestId"] as? String {
                                    requestId = reqId
                                }
                                if let viserId = json["Visiter_Id"] as? String {
                                    visiter_Id = viserId
                                }
                                if let strcaptcha = json["HtmlFormate"] as? String {
                                    captcha = strcaptcha
                                }
                                completion(true)
                            } else if msg == "fail" || msg == "Fail" {
                                completion(false)
                            } else {
                                completion(false)
                            }
                        } else {
                            completion(false)
                        }
                    } else {
                        completion(false)
                    }
                } else {
                    completion(false)
                    print("No Data Found")
                }
            }
            
        }.resume()
    }
}
