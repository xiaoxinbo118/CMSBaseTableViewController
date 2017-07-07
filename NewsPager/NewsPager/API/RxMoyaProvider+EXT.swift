//
//  RxMoyaProvider+EXT.swift
//  NewsPager
//
//  Created by sfht on 5/7/2017.
//  Copyright © 2017 sfht. All rights reserved.
//

import UIKit
import Moya
import RxSwift

class CMNRxMoyaProvider: RxMoyaProvider<CMNAPITarget> {
    var deviceId: String?;
    var appId: String?;
    var userId: String?;
    
    func request<E, R>(_ request: R, entity: E) -> Observable<CMNBaseEntityType> where E: CMNBaseEntityType, R: CMNBaseRequest {
        return self.requests([request], entity: entity).map({ (entities) -> CMNBaseEntityType in
            return entities[0];
        });
    }
    
    func requests<E, R>(_ requests: [R], entity: E) -> Observable<[CMNBaseEntityType]> where E: CMNBaseEntityType, R: CMNBaseRequest  {
        
        
        return Observable.create { observer in
            let params = self.renderParameters(requests: requests);
            
            let cancellableToken = self.request(CMNAPITarget(params)) { result in
                switch result {
                case let .success(response):
//                    observer.onNext(E)

                    observer.onCompleted()
                case let .failure(error):
                    observer.onError(error)
                }
            }
            
            return Disposables.create {
                cancellableToken.cancel()
            }
        }
    }


}

/*
 * 参数返回处理
 */
fileprivate extension CMNRxMoyaProvider {
    
    
    fileprivate func renderParameters(requests:[CMNBaseRequest]) -> [String: String] {
        var securityType = ServerTrustPolicy.None;
        var parameters = [String: String]();
        let methodNames = NSMutableString();
        let length: NSInteger = requests.count;
        
        var index: NSInteger = 0;
        for request: CMNBaseRequest in requests {
            securityType.insert(request.securityType);
        
            for key: String in request.params.keys {
                let value: String? = request.params[key];
                
                if (value != nil) {
                    if CMNAPIParamConstant.METHOD == key {
                        methodNames.append(value!);
                        
                        if (index < length - 1) {
                            methodNames.append(",");
                        }
                    } else {
                        let newKey = length == 1 ? key : key;
                        parameters[newKey] = value;
                    }
                }
            }
            
            index += 1;
        }
        
        parameters[CMNAPIParamConstant.METHOD] = methodNames as String;
        parameters[CMNAPIParamConstant.FORMAT] = "json";
        
        
        //    [params setObject:methodNames forKey:kMethod];
        //    [params setObject:@"json" forKey:kFormat];
        
        if (self.deviceId != nil) {
            parameters[CMNAPIParamConstant.DEVICE_ID] = self.deviceId;
        }
        
        if (self.appId != nil) {
            parameters[CMNAPIParamConstant.APPLICATION_ID] = self.appId;
        }
        
        if (self.userId != nil) {
            parameters[CMNAPIParamConstant.USER_ID] = self.userId;
        }
        
        return parameters;
    }
}

fileprivate class CMNAPIParamConstant {
    static let METHOD: String = "_mt";
    static let FORMAT: String = "_ft";
    static let LOCATION: String = "_lo";
    static let TOKEN: String = "_tk";
    static let SIGNATURE: String = "_sig";
    static let APPLICATION_ID: String = "_aid";
    static let CALL_ID: String = "_cid";
    static let DEVICE_ID: String = "_did";
    static let USER_ID: String = "_uid";
    static let VERSION_CODE: String = "_vc";
    static let VERSION_NAME: String = "_vn";
}

//- (NSString *) parameterStringWithRequests:(NSArray *)requests
//{
//    NSInteger securityType = 0;
//    NSInteger length = requests.count;
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    NSMutableString *methodNames = [[NSMutableString alloc] init];
//    
//    for (NSInteger i = 0; i < length; i ++)
//    {
//        SFBaseRequest *req = requests[i];
//        securityType = securityType | req.securityType;
//        for (NSString *key in req.params.allKeys)
//        {
//            if ([kMethod isEqualToString:key])
//            {
//                [methodNames appendString:req.params[key]];
//                [methodNames appendString:@","];
//            }
//            else
//            {
//                if (length == 1)
//                {
//                    [params setObject:req.params[key] forKey:key];
//                }
//                else
//                {
//                    [params setObject:req.params[key] forKey:[NSString stringWithFormat:@"%ld_%@",i,key]];
//                }
//            }
//        }
//    }
//    NSInteger methodNamesLen = [methodNames length];
//    if (methodNamesLen > 0) {
//        NSRange range;
//        range.location = methodNamesLen - 1;
//        range.length = 1;
//        [methodNames deleteCharactersInRange:range];
//    }
//    
//    [params setObject:methodNames forKey:kMethod];
//    [params setObject:@"json" forKey:kFormat];
//    
//    if (_location && ![params objectForKey:kLocation])
//    {
//        [params setObject:_location forKey:kLocation];
//    }
//    
//    if (_deviceId && ![params objectForKey:kDeviceId])
//    {
//        [params setObject:[NSString stringWithFormat:@"%lld",_deviceId] forKey:kDeviceId];
//    }
//    
//    if (_appid && ![params objectForKey:kApplicationId])
//    {
//        [params setObject:_appid forKey:kApplicationId];
//    }
//    
//    if (_userId && ![params objectForKey:kUserId])
//    {
//        [params setObject:[NSString stringWithFormat:@"%lld",_userId] forKey:kUserId];
//    }
//    
//    if (_vercode && ![params objectForKey:kVersionCode])
//    {
//        [params setObject:[NSString stringWithFormat:@"%ld",(long)_vercode] forKey:kVersionCode];
//    }
//    
//    if (_vername && ![params objectForKey:kVersionName])
//    {
//        [params setObject:_vername forKey:kVersionName];
//    }
//    
//    
//    // todo vernum _src _src_t
//    
//    if(![params objectForKey:kSignatureMethod]){
//        [params setObject:@"sha1" forKey:kSignatureMethod];
//    }
//    //2015/07/07 添加渠道号参数
//    if (![params objectForKey:kChannelId]) {
//        [params setValue:self.channelId forKey:kChannelId];
//    }
//    
//    if ((nil == _userToken || [_userToken isKindOfClass:[NSNull class]] || _userToken.length == 0) && securityType > 0)
//    {
//        if (_deviceToken != nil)
//        {
//            [params setObject:[NSString stringWithFormat:@"%@", _deviceToken] forKey:kDeviceToken];
//        }
//        else
//        {
//            #warning todo 异常处理
//        }
//    }
//    return [self parameterStringInternalWithDictionary:params SecurityType:securityType];
//}
