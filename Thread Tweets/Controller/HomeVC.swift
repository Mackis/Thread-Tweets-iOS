//
//  HomeVC.swift
//  Thread Tweets
//
//  Created by Malcolm Kumwenda on 2017/08/04.
//  Copyright © 2017 mDevSA. All rights reserved.
//

import UIKit
import SnapKit
import TBEmptyDataSet

class HomeVC: UIViewController {
    
    // MARK: - UI Properties
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
    
    lazy var segCtrl: UISegmentedControl = {
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
        sc.addTarget(self, action: #selector(segmentChange), for: .valueChanged)
        return sc
    }()
    
    lazy var composeBtn: UIButton = {
        let btn = UIButton()
        btn.setIcon(icon: .ionicons(.compose), iconSize: 30, color: UIColor.flatMint, backgroundColor: .clear, forState: .normal)
        btn.addTarget(self, action: #selector(self.gotoCompose), for: .touchUpInside)
        btn.showsTouchWhenHighlighted = true 
        return btn
    }()
    
    
    // MARK: - Properties
    var tableView: UITableView!
    var titles = [NSAttributedString(string: ""),  NSAttributedString(string: "")]
    var messages = [NSAttributedString(string: ""),  NSAttributedString(string: "")]
    
    var threads: [[ModelTweet]]? = {
        let fresh = [ModelTweet(), ModelTweet()]
        let featured = [ModelTweet()]
        return [fresh, featured]
    }()
    
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
        headerView.addSubview(segCtrl)
        segCtrl.snp.makeConstraints{ make in
            make.bottom.equalToSuperview().inset(4)
            make.height.equalTo(60)
            make.width.greaterThanOrEqualTo(headerView.snp.width).multipliedBy(0.6)
            make.left.equalToSuperview().inset(8)
        }
        
        // Add Compose btn
        headerView.addSubview(composeBtn)
        composeBtn.snp.makeConstraints{ make in
            make.bottom.equalTo(segCtrl)
            make.height.equalTo(60)
            make.width.equalTo(40)
            make.right.equalToSuperview().inset(1)
        }
        
        // Add Footer
        setupTableView()
    }
    
    func setupTableView(){
        // Add table
        tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = true
        tableView.emptyDataSetDelegate = self
        tableView.emptyDataSetDataSource = self
        tableView.register(TweetCell.self)
        tableView.delaysContentTouches = false 
        
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.width.bottom.equalToSuperview()
        }
    }
    
    @objc func gotoCompose(){
        print("goto")
    }
    
    @objc func segmentChange(){
        tableView.reloadData()
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

extension HomeVC: UITableViewDataSource, UITableViewDelegate {
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (threads?[segCtrl.selectedSegmentIndex].count)!
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as TweetCell
        cell.tweet = ModelTweet()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let threadVC = ThreadVC()
        threadVC.providesPresentationContextTransitionStyle = true
        threadVC.definesPresentationContext = true
        threadVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        threadVC.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        present(threadVC, animated: true)
    }
}

extension HomeVC: TBEmptyDataSetDelegate, TBEmptyDataSetDataSource {
    
    func imageForEmptyDataSet(in scrollView: UIScrollView) -> UIImage? {
        return UIImage.init(icon: .ionicons(.iosBoltOutline), size: CGSize(width: 120, height: 120), textColor: UIColor.flatYellow)
    }
    
    func titleForEmptyDataSet(in scrollView: UIScrollView) -> NSAttributedString? {
        return NSAttributedString(string: "Sorry...")
    }
    
    func descriptionForEmptyDataSet(in scrollView: UIScrollView) -> NSAttributedString? {
        return NSAttributedString(string: "We seem to be experiencing some problems.")
    }
    
    func backgroundColorForEmptyDataSet(in scrollView: UIScrollView) -> UIColor? {
        return .white
    }
    
    func emptyDataSetShouldDisplay(in scrollView: UIScrollView) -> Bool {
        return 0 == 0
    }
    
    func verticalOffsetForEmptyDataSet(in scrollView: UIScrollView) -> CGFloat {
        return CGFloat(-60)
    }
    
}



