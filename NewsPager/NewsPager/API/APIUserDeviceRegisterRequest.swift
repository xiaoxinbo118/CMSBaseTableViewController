//
//  APIUserDeviceRegisterRequest.swift
//  NewsPager
//
//  Created by sfht on 17/7/2017.
//  Copyright © 2017 sfht. All rights reserved.
//

import UIKit

class APIUserDeviceRegisterRequest: CMNBaseRequest {
    init() {
        super.init(method: "user.deviceRegister", securityType: ServerTrustPolicy.None);
    }
}
