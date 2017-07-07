//
//  CMNTextFieldCell.swift
//  NewsPager
//
//  Created by sfht on 3/7/2017.
//  Copyright © 2017 sfht. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CMNTextFieldCellItem: CMNBaseCellItem {
    var text = Variable("");
    
    override init() {
        super.init()
        self.cellClassType = CMNTextFieldCell.classForCoder() as! CMNBaseTableCell.Type ;
    }
}

class CMNTextFieldCell: CMNBaseTableCell {
    let textField: UITextField = UITextField();
    var objectToTextDispose: Disposable? = nil;
    var textToObjectDispose: Disposable? = nil;
    
    override func initCellUI() -> Void {
        self.addSubview(textField);
        textField.backgroundColor = UIColor.red;
    }
    
    override func updateItem(_ item: CMNBaseCellItem?) {
        let object:CMNTextFieldCellItem = item as! CMNTextFieldCellItem;
        
        objectToTextDispose?.dispose();
        objectToTextDispose = object.text
            .asObservable()
            .bind(to: textField.rx.text);
        objectToTextDispose?.addDisposableTo(disposeBag);
        
        textToObjectDispose?.dispose();
        textToObjectDispose = textField.rx.text
            .orEmpty
            .bind(to: object.text);
        textToObjectDispose?.addDisposableTo(disposeBag);
    }
    
    override func layoutSubviews() {
        super.layoutSubviews();
        textField.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
    }
}
