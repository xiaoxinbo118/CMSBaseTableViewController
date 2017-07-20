//
//  CMNBaseRequest.swift
//  NewsPager
//
//  Created by sfht on 4/7/2017.
//  Copyright © 2017 sfht. All rights reserved.
//

import UIKit

//typedef enum
//{
//    SecurityType_None = 0,
//    SecurityType_RegisteredDevice = 0x0100,
//    SecurityType_UserTrustedDevice = 0x0400,
//    SecurityType_MobileOwner = 0x0800,
//    SecurityType_MobileOwnerTrustedDevice = 0x1000,
//    SecurityType_UserLogin = 0x2000,
//    SecurityType_UserLoginAndMobileOwner = SecurityType_UserLogin + SecurityType_MobileOwner,
//    SecurityType_Integrated = 0x10000000,
//    SecurityType_Internal = 0x20000000
//}SecurityType;

//public enum ServerTrustPolicy : Int{
//    case None
//    case RegisteredDevice
//    case UserTrustedDevice
//    case MobileOwner
//    case MobileOwnerTrustedDevice
//    case UserLogin
//    case UserLoginAndMobileOwner
//    case Integrated
//    case Internal
//}

public struct ServerTrustPolicy : OptionSet {
    public var rawValue: UInt = 0;
    
    public init(rawValue:UInt) {
        self.rawValue = rawValue
    }
    
    init(nilLiteral:()) {
        rawValue = 0
    }
    
    func toRaw()->UInt{ return rawValue }
    
    var boolValue:Bool{ return rawValue != 0 }
    
    public static var None: ServerTrustPolicy = ServerTrustPolicy(rawValue: 1 << 0);
    
    public static var RegisteredDevice: ServerTrustPolicy = ServerTrustPolicy(rawValue: 1 << 1);
    
    public static var UserTrustedDevice: ServerTrustPolicy = ServerTrustPolicy(rawValue: 1 << 2);
    
    public static var MobileOwner: ServerTrustPolicy = ServerTrustPolicy(rawValue: 1 << 3);
    
    public static var MobileOwnerTrustedDevice: ServerTrustPolicy = ServerTrustPolicy(rawValue: 1 << 4);
    
    public static var UserLogin: ServerTrustPolicy = ServerTrustPolicy(rawValue: 1 << 5);
    
    public static var UserLoginAndMobileOwner: ServerTrustPolicy = ServerTrustPolicy(rawValue: 1 << 6);
    
    public static var Integrated: ServerTrustPolicy = ServerTrustPolicy(rawValue: 1 << 7);
    
    public static var Internal: ServerTrustPolicy = ServerTrustPolicy(rawValue: 1 << 8);
}

public protocol CMNBaseRequestType
{
    var ignoreDevice: Bool {get};
    var ignoreToken: Bool {get};
    
    func getMethodName() -> String?;
    
}

class CMNBaseRequest: NSObject, CMNBaseRequestType {
    var params = [String: String]();
    var systime:NSInteger = 0;
    var error:NSError?;
    var method: String!;
    var securityType: ServerTrustPolicy!;
    var response: CMNBaseResponse?;
    var ignoreError: Bool = false;
    var ignoreDevice: Bool = false;
    var ignoreToken: Bool = false;
    
    init(method: String!, securityType: ServerTrustPolicy!) {
        super.init();
        
        self.method = method;
        self.securityType = securityType;
    }
    
    func getMethodName() -> String? {
        return method;
    }
}
