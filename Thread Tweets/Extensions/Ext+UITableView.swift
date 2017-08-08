//
//  Ext+UITableView.swift
//  Thread Tweets
//
//  Created by Malcolm Kumwenda on 2017/08/06.
//  Copyright © 2017 mDevSA. All rights reserved.
//

import UIKit
extension UITableView {
    
    func register<T: UITableViewCell>(_: T.Type) {
        
        let nib = UINib(nibName: T.nibName, bundle: nil)
        register(nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        
        return cell
    }
}
