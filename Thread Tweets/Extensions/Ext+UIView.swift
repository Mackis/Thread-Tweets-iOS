//
//  Ext+UIView.swift
//  Thread Tweets
//
//  Created by Malcolm Kumwenda on 2017/08/07.
//  Copyright © 2017 mDevSA. All rights reserved.
//

import UIKit 
extension UIView {
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
