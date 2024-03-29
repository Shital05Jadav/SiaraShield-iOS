//
//  FirstViewModel.swift
//  SiaraShield-iOS
//
//  Created by ShitalJadav on 21/03/23.
//

import UIKit
import Foundation

class FirstViewModel: NSObject {
    
    var firstReq = firstRequest()
    
    func firstAPICall(completion: @escaping( _ ifResult: Bool) -> Void) {
        let url = EndPoint.shared.firstAPIURL()
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = HTTPMethod.POST.rawValue
        
        let header = [
            "Content-Type" : "application/json"
        ]
        firstReq.masterUrlId = masterUrlId
        firstReq.requestUrl = requestUrl
        firstReq.browserIdentity = browserIdentity
        firstReq.deviceIp = deviceIp[1]
        firstReq.deviceType = deviceType
        firstReq.deviceBrowser = deviceBrowser
        firstReq.deviceName = deviceName
        firstReq.deviceHeight = deviceHeight
        firstReq.deviceWidth = deviceWidth
        debugPrint(firstReq)
        guard let jsonObj = firstReq.dictionary else {
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
        request.allHTTPHeaderFields = header
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse {
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
                        if let httpStatusCode = json["HttpStatusCode"] as? Int {
                            if httpStatusCode == 200 || httpStatusCode == 0 {
                                if let reqId = json["RequestId"] as? String {
                                    requestId = reqId
                                }
                                if let visId = json["Visiter_Id"] as? String {
                                    visiter_Id = visId
                                }
                                completion(true)
                            } else {
                                completion(false)
                            }
                        }
                    } else {
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
