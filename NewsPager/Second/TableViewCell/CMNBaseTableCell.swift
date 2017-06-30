//
//  CMNBaseTableCell.swift
//  NewsPager
//
//  Created by sfht on 30/6/2017.
//  Copyright © 2017 sfht. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CMNBaseTableCell: UITableViewCell {
    let disposeBag = DisposeBag();
    
    public let data = Variable(CMNBaseCellItem());
    
    override required init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        
        data
            .asObservable()
            .bind(to: self.rx.cellItem)
            .addDisposableTo(disposeBag);
    }
    
    func updateItem(_ item: CMNBaseCellItem?) -> Void {
        textLabel?.text = "111";
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public class func heightForCellItem(_ item: CMNBaseCellItem) -> CGFloat {
        return 0;
    }
}

extension Reactive where Base: CMNBaseTableCell
{
    internal var cellItem : UIBindingObserver<Base, CMNBaseCellItem?> {
        return UIBindingObserver(UIElement: self.base) { cell, item in
            cell.updateItem(item);
        };
    }
}
