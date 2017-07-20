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
    static let lockDevice: NSObject = NSObject();
    static let lockToken: NSObject = NSObject();
    
    override init() {
        super.init();
        provider.delegate = self;
    }
    
    func deviceRegister() -> Observable<CMNDeviceEntity> {
        return Observable.create({ (observer) -> Disposable in
            
            var deviceDisposable: Disposable?;
            DispatchQueue.global().async(execute: {
                
                objc_sync_enter(CMNBaseBiz.lockDevice);
                let cacheManager = CMNUserCacheManager.sharedInstance;
                let deviceCache: CMNDeviceEntity? = cacheManager.deviceEntity;
                
                if deviceCache != nil {
                    // 其它线程已经拿到数据直接返回
                    observer.onNext(deviceCache!);
                    return;
                }

                let request: APIUserDeviceRegisterRequest = APIUserDeviceRegisterRequest();
                let device: CMNDeviceEntity = CMNDeviceEntity();
                request.ignoreDevice = true;
                
                // 同步请求
                let semaphore = DispatchSemaphore(value: 0)
               
                deviceDisposable = self.provider
                    .request(request, entity: device)
                    .map { (entity) -> CMNDeviceEntity in
                        return entity as! CMNDeviceEntity;
                    }.subscribe(onNext: { (entity) in
                        // 缓存下来
                        cacheManager.deviceEntity = entity;
                        observer.onNext(entity);
                    }, onError: { (error) in
                        observer.onError(error);
                    }, onCompleted: {
                        semaphore.signal();
                        objc_sync_exit(CMNBaseBiz.lockDevice);
                    });
                _ = semaphore.wait(timeout: DispatchTime.distantFuture);
            })
            
            return Disposables.create {
                deviceDisposable?.dispose();
            }
        });
    }
    
    func renewToken() -> Observable<CMNTokenEntity> {
        return Observable.create({ (observer) -> Disposable in
            
            var deviceDisposable: Disposable?;
            DispatchQueue.global().async(execute: {
                
                objc_sync_enter(CMNBaseBiz.lockToken);
                let cacheManager = CMNUserCacheManager.sharedInstance;
                let tokenCache: CMNTokenEntity? = cacheManager.tokenEntity;
                
                if tokenCache != nil && tokenCache?.isExpire() == false {
                    // 其它线程已经拿到数据直接返回
                    observer.onNext(tokenCache!);
                    return;
                }
                
                let request: APIRenewTokenRequest = APIRenewTokenRequest();
                let device: CMNDeviceEntity = CMNDeviceEntity();
                request.ignoreToken = true;
                
                // 同步请求
                let semaphore = DispatchSemaphore(value: 0)
                
                deviceDisposable = self.provider
                    .request(request, entity: device)
                    .map { (entity) -> CMNTokenEntity in
                        return entity as! CMNTokenEntity;
                    }.subscribe(onNext: { (entity) in
                        // 缓存下来
                        cacheManager.tokenEntity = entity;
                        observer.onNext(entity);
                    }, onError: { (error) in
                        observer.onError(error);
                    }, onCompleted: {
                        semaphore.signal();
                        objc_sync_exit(CMNBaseBiz.lockToken);
                    });
                _ = semaphore.wait(timeout: DispatchTime.distantFuture);
            })
            
            return Disposables.create {
                deviceDisposable?.dispose();
            }
        })
    }

    func preparationOfScheduleForRequests(_ requests: [CMNBaseRequestType]) -> Observable<CMNDeviceAndTokenEntity> {
        return Observable.create({ (observer) -> Disposable in
            var ignoreDevice: Bool = true;
            var ignoreToken: Bool = true;
            for request: CMNBaseRequestType in requests {
                if (request.ignoreDevice == false && ignoreDevice == true) {
                    ignoreDevice = false;
                }
                if (request.ignoreToken == false && ignoreToken == true) {
                    ignoreToken = false;
                }
            }

            let cacheManager = CMNUserCacheManager.sharedInstance;
            let device: CMNDeviceEntity? = cacheManager.deviceEntity;
            
            var deviceDisposable: Disposable?;
            var tokenDisposable: Disposable?;
            
            let successBlock: (CMNDeviceEntity?, CMNTokenEntity?) -> Void = { device, token -> Void in
                let result: CMNDeviceAndTokenEntity = CMNDeviceAndTokenEntity();
                result.device = device;
                result.token = token
                observer.onNext(result);
            };
            
            let errorBlock: (Error) -> Void = { error -> Void in
                observer.onError(error);
            };
            
            // 2. 验证Token
            let tokenBlock: (CMNDeviceEntity?) -> Void = { device -> Void in
                let token: CMNTokenEntity? = cacheManager.tokenEntity;
                if (ignoreToken == false && token != nil && token!.isExpire() == true) {
                    tokenDisposable = self.renewToken()
                        .subscribe(onNext: { (tokenEntity) in
                            successBlock(device, tokenEntity);
                        }, onError: { (error) in
                            errorBlock(error);
                        }, onCompleted: {
                            
                        });
                } else {
                    successBlock(device, token);
                }
            };
            
            // 1. 验证Device
            if device == nil && !ignoreDevice {
                deviceDisposable = self.deviceRegister()
                    .subscribe(onNext: { (deviceEntity) in
                        tokenBlock(deviceEntity);
                    }, onError: { (error) in
                        errorBlock(error);
                    }, onCompleted: {
                        
                    });
            } else {
                tokenBlock(device);
            }
            
            return Disposables.create {
                deviceDisposable?.dispose();
                tokenDisposable?.dispose();
            }
        })
    }
}
