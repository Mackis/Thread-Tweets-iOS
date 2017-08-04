//
//  HomeVC.swift
//  Thread Tweets
//
//  Created by Malcolm Kumwenda on 2017/08/04.
//  Copyright © 2017 mDevSA. All rights reserved.
//

import UIKit
import SnapKit

class HomeVC: UIViewController {
    
    lazy var headerView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.layer.shadowOffset = CGSize(width: 1, height: 0.5)
        v.layer.shadowOpacity = 0.7
        
        let separator = UIView()
        separator.backgroundColor = UIColor.lightGray
        v.addSubview(separator)
        separator.snp.makeConstraints{ make in
            make.bottom.width.equalTo(v)
            make.height.equalTo(1)
        }
        return v
    }()
    
    lazy var sectionControl: UISegmentedControl = {
        let sc = UISegmentedControl()
        sc.insertSegment(withTitle: "Featured", at: 0, animated: true)
        sc.setTitle("Featured", forSegmentAt: 0)
        sc.insertSegment(withTitle: "Fresh", at: 1, animated: true)
        sc.setTitle("Fresh", forSegmentAt: 1)
        let unSelectAttr = [NSAttributedStringKey.foregroundColor: UIColor.lightGray.withAlphaComponent(0.7), NSAttributedStringKey.font: UIFont(name: "Futura-Bold", size: 20.0)!]
        let selectAttr = [NSAttributedStringKey.foregroundColor: UIColor.black, NSAttributedStringKey.font: UIFont(name: "Futura-Bold", size: 20.0)!]
        UISegmentedControl.appearance().setTitleTextAttributes(unSelectAttr as [NSObject : AnyObject] , for: .normal)
        UISegmentedControl.appearance().setTitleTextAttributes(selectAttr as [NSObject : AnyObject] , for: .selected)
        sc.tintColor = UIColor.white
        sc.removeBorders()
        sc.selectedSegmentIndex = 0
        return sc
    }()

    
    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
    }
    func setupView(){
        view.backgroundColor = UIColor.white
        
        // Add header
        view.addSubview(headerView)
        headerView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(80)
            make.top.equalToSuperview()
        }
        // Add Sections
        headerView.addSubview(sectionControl)
        sectionControl.snp.makeConstraints{ make in
            make.bottom.equalToSuperview().inset(8)
            make.height.equalTo(60)
            make.width.equalToSuperview().multipliedBy(0.6)
            make.left.equalToSuperview().inset(8)
        }
        
        // Add table
        let table: UITableViewController = ThreadsTVC()
        let tableView: UITableView = UITableView()
        tableView.dataSource = table
        tableView.delegate = table
        self.view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.width.bottom.equalToSuperview()
        }
    }
    
}

extension UISegmentedControl {
    func removeBorders() {
        setBackgroundImage(imageWithColor(color: UIColor.clear), for: .normal, barMetrics: .default)
        setBackgroundImage(imageWithColor(color: tintColor!), for: .selected, barMetrics: .default)
        setDividerImage(imageWithColor(color: UIColor.clear), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
    }
    
    private func imageWithColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0.0, y: 0.0, width:  1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor);
        context!.fill(rect);
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image!
    }
}
