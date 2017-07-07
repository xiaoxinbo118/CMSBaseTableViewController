//
//  CMNBaseBiz.swift
//  NewsPager
//
//  Created by sfht on 5/7/2017.
//  Copyright © 2017 sfht. All rights reserved.
//

import UIKit
import RxSwift

public extension ObservableType where E == CMNBaseEntityType {
    public func logic<T: CMNBaseEntityType>(_ logic: @escaping (_ entity: T) -> T) -> Observable<T> {
        return flatMap { response -> Observable<T> in
            let v: T = logic(response as! T);
            return Observable.just(v);
        }
    }
}

class CMNBaseBiz: NSObject, CMNRxMoyaProviderDelegate {
    let provider: CMNRxMoyaProvider = CMNRxMoyaProvider();
    
    override init() {
        super.init();
        provider.delegate = self;
    }
    
    func tokenExprise(_ requests: [CMNBaseRequestType], _ callback: @escaping (Bool, NSError?) -> Void) {
        callback(true, nil);
        
//        let
        
//        provider.request(<#T##request: R##R#>, entity: <#T##CMNBaseEntityType#>)
        
    }
}
