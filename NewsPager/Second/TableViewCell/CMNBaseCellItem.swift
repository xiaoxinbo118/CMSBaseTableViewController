//
//  CMNBaseCellItem.swift
//  NewsPager
//
//  Created by sfht on 30/6/2017.
//  Copyright © 2017 sfht. All rights reserved.
//

import UIKit

//protocol CMNCellItem<S> {
//    var target: AnyObject { get }
//    var keyPath: String { get }
//    var retainTarget: Bool { get }
//    var options: NSKeyValueObservingOptions { get }
//}

class CMNBaseCellItem: NSObject {
    private var _cellClassType: CMNBaseTableCell.Type! = CMNBaseTableCell.classForCoder() as! CMNBaseTableCell.Type;
    private var _identifier:String! = "";
    
    var hiddenSeparateLine:Bool! = false;
    
    var hiddenRightArrow:Bool! = false;
    
    var rightLineIndent:CGFloat! = 0;
    
    var leftLineIndent:CGFloat! = 0;
    
    var height:CGFloat! = 44;
    
    var response:AnyObject! = nil;

    var cellClassType:CMNBaseTableCell.Type! {
        set (type) {
            _cellClassType = type;
            if (type != nil) {
                _identifier = NSStringFromClass(type!);
            } else {
                _identifier = "";
            }
        }
        get {
            return _cellClassType;
        }
    };

    var identifier:String! {
        get {
            return _identifier;
        }
    }
    
    override init() {
        super.init();
    }
}
