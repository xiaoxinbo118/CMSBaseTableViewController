//
//  CMSBaseTable.swift
//  NewsPager
//
//  Created by sfht on 30/6/2017.
//  Copyright © 2017 sfht. All rights reserved.
//

import UIKit

import RxSwift
import Kingfisher
import RxCocoa
import RxDataSources
import SwiftDate
import Then

/**
 * TableViewController封装，子类只需要组装数据，放入items里。刷新调用updateItems
 **/
class CMNBaseTableViewController: CMNBaseViewController, UIScrollViewDelegate{
    public let tableView: UITableView! = UITableView();
    public var items: [CMNBaseCellItem]! = [CMNBaseCellItem]();
    public let disposeBag:DisposeBag! = DisposeBag();
    fileprivate let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<CMNBaseCellItem, CMNBaseCellItem>>()
    fileprivate let datas = Variable([SectionModel<CMNBaseCellItem, CMNBaseCellItem>]());

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.frame = self.view.bounds;
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none;
        tableView.autoresizingMask = [UIViewAutoresizing.flexibleHeight, UIViewAutoresizing.flexibleWidth];
        self.view.addSubview(tableView);
        
        dataSource.configureCell = { (dataSource, tv, indexPath, item) in
            var cell = tv.dequeueReusableCell(withIdentifier: item.identifier);
            
            if (cell == nil) {
                cell = item.cellClassType.init(style: UITableViewCellStyle.default, reuseIdentifier: item.identifier);
            }
            
            if (cell!.isKind(of: CMNBaseTableCell.classForCoder())) {
                let baseCell: CMNBaseTableCell = cell as! CMNBaseTableCell;
                baseCell.data.value = item;
                
            }

            return cell!;
        }

        tableView.rx
            .setDelegate(self)
            .addDisposableTo(disposeBag)
        
        datas
            .asObservable()
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .addDisposableTo(disposeBag);
    }
    
    public func updateItems() {
        var sections = [SectionModel<CMNBaseCellItem, CMNBaseCellItem>]();
        let section = SectionModel<CMNBaseCellItem, CMNBaseCellItem>(model:CMNBaseCellItem(), items:self.items);

        sections.append(section);
        self.datas.value = sections;
    }
}

/**
 *  TableView 代理实现的地方
 **/
extension CMNBaseTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        let item: CMNBaseCellItem = self.dataSource[indexPath];
        var height: CGFloat = item.cellClassType.heightForCellItem(item);
        
        if (height == 0) {
            height = item.height;
        }
        
        return height;
    }
}


