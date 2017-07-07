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

public extension ObservableType where E == CMNBaseEntityType {
    public func logic<T: CMNBaseEntityType>(_ logic: @escaping (_ entity: T) -> T) -> Observable<T> {
        return flatMap { response -> Observable<T> in
            let v: T = logic(response as! T);
            return Observable.just(v);
        }
    }
    
    public func get() -> Void {
        
    }
}

extension Response {
    func mapModel<T: CMNBaseResponse>(_ type: T.Type) -> T {
        let jsonString = String.init(data: data, encoding: .utf8)
        // todo 转换
        return jsonString as! T; //JSONDeserializer<T>.deserializeFrom(json: jsonString)!
    }
}

class CMNUserBiz: CMNBaseBiz {
    
    static var sharedInstance: CMNUserBiz = CMNUserBiz();
    
    private override init() {
        super.init();
    }
    
    
    func login(account: String, password: String) -> Observable<CMNUserEntity>? {
        let provider: CMNRxMoyaProvider = CMNRxMoyaProvider();
        
        let request: APIUserLoginRquest = APIUserLoginRquest(account: account, type: "Tel", password: password);
        // todo 自己要map一下。
        let entity: CMNUserEntity = CMNUserEntity();
        return provider
                .request(request, entity: entity)
                .logic({ (entity) -> CMNUserEntity in
                    return entity;
                });
    }
    
//    func login() -> Disposable {
//        
//    }
}
