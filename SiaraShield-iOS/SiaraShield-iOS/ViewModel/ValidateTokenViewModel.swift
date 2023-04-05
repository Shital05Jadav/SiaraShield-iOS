//
//  ValidateTokenViewModel.swift
//  SiaraShield_iOS
//
//  Created by ShitalJadav on 03/04/23.
//

import Foundation

import UIKit
class ValidateTokenViewModel: NSObject {
        
    func validatetokenAPICall(completion: @escaping( _ ifResult: Bool) -> Void) {
        let url = EndPoint.shared.validateToken()
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = HTTPMethod.GET.rawValue
        
        let header = [
            "Content-Type" : "application/json",
                "ip" : deviceIp[1],
                "key" : privateKey
            ]
      
        
        request.allHTTPHeaderFields = header
       
        if token != "" {
            request.setValue(
                "Bearer \(token)",
                forHTTPHeaderField: "Authentication"
            )
        } else {
            completion(false)
        }
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse {
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
                        if let httpStatusCode = json["HttpStatusCode"] as? Int {
                            if httpStatusCode == 200 || httpStatusCode == 0 {
                                completion(true)
                            } else {
                                completion(false)
                            }
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
