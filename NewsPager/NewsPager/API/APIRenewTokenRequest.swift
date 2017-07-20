//
//  APIRenewTokenRequest.swift
//  NewsPager
//
//  Created by sfht on 19/7/2017.
//  Copyright © 2017 sfht. All rights reserved.
//

import UIKit

class APIRenewTokenRequest: CMNBaseRequest {
    init() {
        super.init(method: "user.renewToken", securityType: ServerTrustPolicy.None);
    }
}
