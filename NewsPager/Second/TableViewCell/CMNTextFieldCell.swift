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
    
    override func initCellUI() -> Void {
        self.addSubview(textField);
        textField.backgroundColor = UIColor.red;
    }
    
    override func updateItem(_ item: CMNBaseCellItem?) {
        let object:CMNTextFieldCellItem = item as! CMNTextFieldCellItem;

        object.text
            .asObservable()
            .bind(to: textField.rx.text)
            .addDisposableTo(self.disposeBag);
//        textField.rx.text.subscribe(<#T##observer: ObserverType##ObserverType#>)
//        textField.rx.text.bind(to: object.text)
//            .addDisposableTo(self.disposeBag);
        
//        textField.rx.text.bind(to: object.text.asObservable()).addDisposableTo(self.disposeBag);
        
//        let text = Variable("双向绑定")
//        
//        _  = textField.rx.textInput <-> text
//        textField
//        textField.rx.text
//            .asObservable()
//            .subscribe{
//                print("textfield: \($0)")
//            }
//            .disposed(by: disposeBag)

    }
    
    override func layoutSubviews() {
        super.layoutSubviews();
        textField.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
    }
}
