//
//  CMNTokenEntity.swift
//  NewsPager
//
//  Created by sfht on 18/7/2017.
//  Copyright © 2017 sfht. All rights reserved.
//

import UIKit

class CMNTokenEntity: CMNBaseEntity {
    static let ONE_DAY: CGFloat = 60 * 60 * 24;
    
    // 账户id
    var userId: NSInteger?;
    
    // 登录凭据
    var token: String?;
    
    // csrf token
    var csrfToken: String?;
    
    //2015-6-8号新增字段（升级处理）
    var cookieInfo: String?;
    
    // web端token
    var webToken: String?;
    
    // web端csrfToken
    var webCsrfToken: String?;
    
    // 过期时间
    var expire: NSInteger = 0;
    
    func isExpire() -> Bool {
        let now: NSDate = NSDate();
        
        if (self.expire == 0) {
            return true;
        }
        
        let ex:NSDate = NSDate(timeIntervalSince1970: Double(CGFloat(self.expire) / 1000.0 - CMNTokenEntity.ONE_DAY));
        
        if (now.timeIntervalSince1970 >= ex.timeIntervalSince1970) {
            return true;
        } else {
            return false;
        }
    }
}
