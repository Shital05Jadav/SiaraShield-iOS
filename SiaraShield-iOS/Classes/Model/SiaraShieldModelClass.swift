//
//  SiaraShieldModelClass.swift
//  SiaraShield-iOS
//
//  Created by ShitalJadav on 21/03/23.
//

import Foundation
import UIKit

struct firstRequest : Codable {
    var masterUrlId : String
    var requestUrl : String
    var browserIdentity :String
    var deviceIp : String
    var deviceType : String
    var deviceBrowser :String
    var deviceName : String
    var deviceHeight : String
    var deviceWidth :String
    
    init() {
        self = .init(data: [:])
    }
    
    init(data : [String:Any]) {
        self.masterUrlId = data["MasterUrlId"] as? String ?? ""
        self.requestUrl = data["RequestUrl"] as? String ?? ""
        self.browserIdentity = data["BrowserIdentity"] as? String ?? ""
        self.deviceIp = data["DeviceIp"] as? String ?? ""
        self.deviceType = data["DeviceType"] as? String ?? ""
        self.deviceBrowser = data["DeviceBrowser"] as? String ?? ""
        self.deviceName = data["DeviceName"] as? String ?? ""
        self.deviceHeight = data["DeviceHeight"] as? String ?? ""
        self.deviceWidth = data["DeviceWidth"] as? String ?? ""
    }
}

struct submitCaptchaRequest : Codable {
    var masterUrlId : String
    var deviceIp : String
    var deviceName :String
    var browserIdentity : String
    var strProtocol : String
    var second :String
    var requestID : String
    var visiterId : String
    
    
    init() {
        self = .init(data: [:])
    }
    
    init(data : [String:Any]) {
        self.masterUrlId = data["MasterUrlId"] as? String ?? ""
        self.deviceIp = data["DeviceIp"] as? String ?? ""
        self.deviceName = data["DeviceName"] as? String ?? ""
        self.browserIdentity = data["BrowserIdentity"] as? String ?? ""
        self.strProtocol = data["Protocol"] as? String ?? ""
        self.second = data["second"] as? String ?? ""
        self.requestID = data["RequestID"] as? String ?? ""
        self.visiterId = data["VisiterId"] as? String ?? ""
    }
}
    
    struct generateCaptchaRequest : Codable {
        var masterUrlId : String
        var requestUrl : String
        var browserIdentity :String
        var deviceIp : String
        var deviceType : String
        var deviceBrowser :String
        var deviceName : String
        var deviceHeight : String
        var deviceWidth :String
        var visiterId: String
        
        init() {
            self = .init(data: [:])
        }
        
        init(data : [String:Any]) {
            self.masterUrlId = data["MasterUrlId"] as? String ?? ""
            self.requestUrl = data["RequestUrl"] as? String ?? ""
            self.browserIdentity = data["BrowserIdentity"] as? String ?? ""
            self.deviceIp = data["DeviceIp"] as? String ?? ""
            self.deviceType = data["DeviceType"] as? String ?? ""
            self.deviceBrowser = data["DeviceBrowser"] as? String ?? ""
            self.deviceName = data["DeviceName"] as? String ?? ""
            self.deviceHeight = data["DeviceHeight"] as? String ?? ""
            self.deviceWidth = data["DeviceWidth"] as? String ?? ""
            self.visiterId = data["VisiterId"] as? String ?? ""
        }
    }
    
    struct captchVerifyRequest : Codable {
        var masterUrlId : String
        var deviceIp : String
        var deviceType :String
        var deviceName : String
        var userCaptcha : String
        var byPass :String
        var browserIdentity : String
        var timespent : String
        var strProtocol :String
        var flag: String
        var second : String
        var requestID : String
        var visiterId :String
        var fillupsecond: String
        
        init() {
            self = .init(data: [:])
        }
        
        init(data : [String:Any]) {
            self.masterUrlId = data["MasterUrlId"] as? String ?? ""
            self.deviceIp = data["DeviceIp"] as? String ?? ""
            self.deviceType = data["DeviceType"] as? String ?? ""
            self.deviceName = data["DeviceName"] as? String ?? ""
            self.userCaptcha = data["UserCaptcha"] as? String ?? ""
            self.byPass = data["ByPass"] as? String ?? ""
            self.browserIdentity = data["BrowserIdentity"] as? String ?? ""
            self.timespent = data["Timespent"] as? String ?? ""
            self.strProtocol = data["Protocol"] as? String ?? ""
            self.flag = data["Flag"] as? String ?? ""
            self.second = data["second"] as? String ?? ""
            self.requestID = data["RequestID"] as? String ?? ""
            self.visiterId = data["VisiterId"] as? String ?? ""
            self.fillupsecond = data["fillupsecond"] as? String ?? ""
        }
    }
    
    struct firstResponse: Decodable {
        let HttpStatusCode: Int?
        let Message: String?
        let data: String?
        let Captcha: String?
        let HtmlFormate: String?
        let SecurityLevel: String?
        let RequestId: String?
        let FpStatus: String?
        let VisiterLanguage: String?
        let Visiter_Id: String?
        
        enum CodingKeys: String, CodingKey {
                case HttpStatusCode, Message, data, Captcha, HtmlFormate, SecurityLevel, RequestId, FpStatus, VisiterLanguage, Visiter_Id // API returns
            }
    }
    
    struct submitCaptchaResponse: Codable {
        var HttpStatusCode : Int?
        var Message : String?
        var data : String?
        var Captcha : String?
        var HtmlFormate : String?
        var SecurityLevel : String?
        var RequestId : String?
        var FpStatus : String?
        var VisiterLanguage : String?
        var Visiter_Id : String?
        
        enum CodingKeys: String, CodingKey {
                case HttpStatusCode, Message, data, Captcha, HtmlFormate, SecurityLevel, RequestId, FpStatus, VisiterLanguage, Visiter_Id // API returns
            }
    }

struct generateCaptchaResponse: Codable {
    var HttpStatusCode: Int?
    var Message : String?
    var HtmlFormate : String?
    var data : String?
    var Captcha : String?
    var SecurityLevel : String?
    var RequestId : String?
    var FpStatus : String?
    var VisiterLanguage: String?
    var Visiter_Id: String?
    
    enum CodingKeys: String, CodingKey {
            case HttpStatusCode, Message,HtmlFormate, data, Captcha, SecurityLevel, RequestId, FpStatus, VisiterLanguage, Visiter_Id // API returns
        }
}
   
struct captchaVerifyResponse: Codable {
    var HttpStatusCode: Int?
    var Message : String?
    var data : String?
    var Captcha : String?
    var HtmlFormate : String?
    var SecurityLevel : String?
    var FpStatus : String?
    var RequestId: String?
    var Visiter_Id: String?
    var VisiterLanguage: String?
    
    enum CodingKeys: String, CodingKey {
        case HttpStatusCode, Message, data, Captcha,HtmlFormate, SecurityLevel, FpStatus,RequestId, Visiter_Id, VisiterLanguage // API returns
        }
}

