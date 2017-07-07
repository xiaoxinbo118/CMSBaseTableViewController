//
//  CMNAPITarget.swift
//  NewsPager
//
//  Created by sfht on 5/7/2017.
//  Copyright © 2017 sfht. All rights reserved.
//

import UIKit
import Moya

class CMNAPITarget: NSObject, TargetType {
    var params: [String: Any]?;
    
    
    init(_ params: [String: Any]?) {
        super.init();
        self.params = params;
    }
    
    /// The target's base `URL`.
    var baseURL: URL {
        return URL.init(string: "https://m.fengqu.com")!
    }
    
    /// The HTTP method used in the request.
    var method: Moya.Method {
        return .post
    }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String {
        return "m.api";
    }
    
    /// The parameters to be incoded in the request.
    var parameters: [String: Any]? {
        return params;
    }
    
    /// The method used for parameter encoding.
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    /// Provides stub data for use in testing.
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    /// The type of HTTP task to be performed.
    var task: Task {
        return .request
    }
    
    /// Whether or not to perform Alamofire validation. Defaults to `false`.
    var validate: Bool {
        return false
    }

}
