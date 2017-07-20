//
//  CMNUserCacheManager.swift
//  NewsPager
//
//  Created by sfht on 18/7/2017.
//  Copyright © 2017 sfht. All rights reserved.
//

import UIKit
import HandyJSON

class CMNUserCacheManager: NSObject {
    static var sharedInstance: CMNUserCacheManager = CMNUserCacheManager();
    private var _userEntity: CMNUserEntity?;
    private var _deviceEntity: CMNDeviceEntity?;
    private var _tokenEntity: CMNTokenEntity?;

    var userEntity: CMNUserEntity? {
        get {
            if _userEntity == nil {
                _userEntity = JSONDeserializer<CMNUserEntity>.deserializeFrom(json: self.getEntity(key: "user_entity"));
            }
            return _userEntity;
        }
        set (user) {
            _userEntity = user;
            
            self.saveEntity(key: "user_entity", value: user?.toJSONString());
        }
    }

    var deviceEntity: CMNDeviceEntity? {
        get {
            if _deviceEntity == nil {
                _deviceEntity = JSONDeserializer<CMNDeviceEntity>.deserializeFrom(json: self.getEntity(key: "device_entity"));
            }
            return _deviceEntity;
        }
        set (device) {
            _deviceEntity = device;
            
            self.saveEntity(key: "device_entity", value: device?.toJSONString());
        }
    }
    
    var tokenEntity: CMNTokenEntity? {
        get {
            if _tokenEntity == nil {
                _tokenEntity = JSONDeserializer<CMNTokenEntity>.deserializeFrom(json: self.getEntity(key: "token_entity"));
            }
            return _tokenEntity;
        }
        set (token) {
            _tokenEntity = token;
            
            self.saveEntity(key: "token_entity", value: token?.toJSONString());
        }
    }
    
    
    private func saveEntity(key: String, value: String?) -> Void {
        UserDefaults.standard.setValue(value, forKey: key);
        UserDefaults.standard.synchronize();
    }
    
    private func getEntity(key: String) -> String? {
        let value = UserDefaults.standard.value(forKey: key);
        
        return value as? String
    }
}
