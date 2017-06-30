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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let item: CMNBaseCellItem = CMNBaseCellItem();
        item.height = 100;
        self.items.append(item);
        self.items.append(item);
        self.updateItems();
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

