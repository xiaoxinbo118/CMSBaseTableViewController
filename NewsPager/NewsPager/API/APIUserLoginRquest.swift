//
//  APIUserLoginRquest.swift
//  NewsPager
//
//  Created by sfht on 4/7/2017.
//  Copyright © 2017 sfht. All rights reserved.
//

import UIKit

class APIUserLoginRquest: CMNBaseRequest {

    init(account: String!, type: String!, password: String!) {
        super.init(method: "user.appLogin", securityType: ServerTrustPolicy.RegisteredDevice);
        self.params["accountId"] = account;
        self.params["type"] = type;
        self.params["password"] = password;
    }
}
