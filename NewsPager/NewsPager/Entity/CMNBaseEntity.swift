//
//  CMNBaseEntity.swift
//  NewsPager
//
//  Created by sfht on 6/7/2017.
//  Copyright © 2017 sfht. All rights reserved.
//

import UIKit
import HandyJSON;

public protocol CMNBaseEntityType
{
    
}

open class CMNBaseEntity: NSObject, CMNBaseEntityType, HandyJSON {
    public override required init() {
        super.init();
    }
}
