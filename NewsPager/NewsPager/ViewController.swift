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
    let text2 = Variable("");
    let text3 = Variable("");
    let text4 = Variable("");
    let text5 = Variable("");
    let text6 = Variable("");
    let text7 = Variable("");
    let text8 = Variable("");
    let text9 = Variable("");
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
            let item1: CMNTextFieldCellItem = CMNTextFieldCellItem();
            item1.height = 200;
            item1.text = text1;
            self.items.append(item1);

        
        
        
        self.updateItems();
        
        
        
        CMNUserBiz.sharedInstance
            .login(account: "18621311552", password: "426297218")?
            .subscribe(onNext: { (userEntity) in
            
        }, onError: { (error) in
            
        }, onCompleted: {
            
        }).addDisposableTo(disposeBag);
        
//        let btn: UIButton = UIButton(type: UIButtonType.contactAdd);
//        btn.addTarget(self, action: #selector(update), for: UIControlEvents.touchUpInside);
//        btn.frame = CGRect(x:200, y:200, width:20, height:20);
//        self.view.addSubview(btn);
//
//        let textField: UITextField = UITextField();
//        self.view.addSubview(textField);
//        textField.backgroundColor = UIColor.blue;
//        textField.frame = CGRect(x: 0, y: 210, width:self.view.frame.size.width, height: self.view.frame.size.height);
//        
//        text1.asObservable().bind(to: textField.rx.text).addDisposableTo(disposeBag);
    }
    
    func update() -> Void {
//        text1.value = "111";
        NSLog("text1 %@", text1.value);
        NSLog("text2 %@", text2.value);
        NSLog("text3 %@", text3.value);
        NSLog("text4 %@", text4.value);
        NSLog("text5 %@", text5.value);
        NSLog("text6 %@", text6.value);
        NSLog("text7 %@", text7.value);
        NSLog("text8 %@", text8.value);
        NSLog("text9 %@", text9.value);
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

