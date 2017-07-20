//
//  CMNUserBiz.swift
//  NewsPager
//
//  Created by sfht on 5/7/2017.
//  Copyright © 2017 sfht. All rights reserved.
//

import UIKit
import RxSwift
import Moya

import Foundation
import RxSwift
import Moya
import HandyJSON



class CMNUserBiz: CMNBaseBiz {
    
    static var sharedInstance: CMNUserBiz = CMNUserBiz();
    
    private override init() {
        super.init();
    }
    
    func login(account: String, password: String) -> Observable<CMNUserEntity>? {
        let request: APIUserLoginRquest = APIUserLoginRquest(account: account, type: "Tel", password: password);
        // todo 自己要map一下。
        let entity: CMNUserEntity = CMNUserEntity();
        return provider
                .request(request, entity: entity)
                .map({ (entity) -> CMNUserEntity in
                    // 实体处理
                    return entity as! CMNUserEntity;
                })
                .do(onNext: { (entity) in
                    // 业务逻辑
                });
    }
}
