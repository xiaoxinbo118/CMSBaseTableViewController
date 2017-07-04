//
//  ViewController.swift
//  NewsPager
//
//  Created by sfht on 28/6/2017.
//  Copyright © 2017 sfht. All rights reserved.
//

import UIKit
import Moya
import RxSwift
import Kingfisher
import RxCocoa
import RxDataSources
import SwiftDate
import Then

//import RxTableViewSectionedReloadWithHeaderViewDataSource

class ViewController: CMNBaseTableViewController {
    let text1 = Variable("");

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let item: CMNTextFieldCellItem = CMNTextFieldCellItem();
        item.height = 100;
        item.text = text1;
        self.items.append(item);
        self.updateItems();
    
        let btn: UIButton = UIButton(type: UIButtonType.contactAdd);
        btn.addTarget(self, action: #selector(update), for: UIControlEvents.touchUpInside);
        btn.frame = CGRect(x:200, y:200, width:20, height:20);
        self.view.addSubview(btn);
        
        let textField: UITextField = UITextField();
        self.view.addSubview(textField);
        textField.backgroundColor = UIColor.blue;
        textField.frame = CGRect(x: 0, y: 210, width:self.view.frame.size.width, height: self.view.frame.size.height);
        
        text1.asObservable().bind(to: textField.rx.text).addDisposableTo(disposeBag);
    }
    
    func update() -> Void {
//        text1.value = "111";
        NSLog("%@", text1.value);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

