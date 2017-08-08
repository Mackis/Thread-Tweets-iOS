//
//  NibLoadable.swift
//  Thread Tweets
//
//  Created by Malcolm Kumwenda on 2017/08/06.
//  Copyright © 2017 mDevSA. All rights reserved.
//

import UIKit

protocol NibLoadable: class { }

extension NibLoadable where Self: UIView {
    
    static var nibName: String {
        return String(describing: self)
    }
    
}

extension UITableViewCell: NibLoadable { }
extension UICollectionViewCell: NibLoadable { }
