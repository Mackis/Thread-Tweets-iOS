//
//  Reusable.swift
//  Thread Tweets
//
//  Created by Malcolm Kumwenda on 2017/08/06.
//  Copyright © 2017 mDevSA. All rights reserved.
//

import UIKit
protocol Reusable: class {}

extension Reusable where Self: UIView {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
}

extension UITableViewCell: Reusable { }
extension UICollectionViewCell: Reusable { }
