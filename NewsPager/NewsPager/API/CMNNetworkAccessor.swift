//
//  CMNNetworkAccess.swift
//  NewsPager
//
//  Created by sfht on 5/7/2017.
//  Copyright © 2017 sfht. All rights reserved.
//

import UIKit
import RxSwift
import Result

public typealias NetworkCompletion = (_ result: Result<CMNBaseResponse, NSError>) -> Void;

class CMNNetworkAccessor: NSObject {
    func asyncRequest(_ request: CMNBaseRequest) -> Observable<CMNBaseResponse> {
        
        let requests = [request];

        return self.asyncRequest(requests);
    }
    
    func asyncRequest(_ requests: [CMNBaseRequest]) -> Observable<CMNBaseResponse> {
        return Observable.create({ (observer) -> Disposable in
            self.asyncRequest(requests) { result in
                switch result {
                case let .success(response):
                    observer.onNext(response)
                    observer.onCompleted()
                case let .failure(error):
                    observer.onError(error)
                }
            }
            
            return Disposables.create {
                
            };
        })
    }
    
    func asyncRequest(_ requests: [CMNBaseRequest], completion: @escaping NetworkCompletion) {
        
    }
}
