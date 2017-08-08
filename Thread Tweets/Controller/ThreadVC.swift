//
//  ThreadVC.swift
//  Thread Tweets
//
//  Created by Malcolm Kumwenda on 2017/08/07.
//  Copyright © 2017 mDevSA. All rights reserved.
//

import UIKit
import TBEmptyDataSet

class ThreadVC: UIViewController {
    
   
    // MARK: - Properties
    var tableView: UITableView!
    let fresh = [ModelTweet(), ModelTweet()]
    
    lazy var contentView: UIView = {
        let v = UIView()
        v.layer.cornerRadius = 10
        v.backgroundColor = .white
        let closeBtn = UIButton()
        v.addSubview(closeBtn)
        closeBtn.setIcon(icon: .ionicons(.iosArrowDown), iconSize: nil, color: .flatPlumDark, forState: .normal)
        closeBtn.addTarget(self, action: #selector(dissmiss), for: .touchUpInside)
        closeBtn.snp.makeConstraints({ (make) in
            make.top.left.equalToSuperview().inset(8)
            make.height.width.equalTo(30)
        })
        
        let favBtn = UIButton()
        favBtn.setIcon(icon: .ionicons(.bookmark), iconSize: CGFloat(25), color: .flatBlack, forState: .normal)
        favBtn.addTarget(self, action: #selector(dissmiss), for: .touchUpInside)
        
        let likeBtn = UIButton()
        likeBtn.setIcon(icon: .ionicons(.iosHeart), iconSize: CGFloat(25), color: .flatSkyBlue, forState: .normal)
        likeBtn.addTarget(self, action: #selector(dissmiss), for: .touchUpInside)
        
        let retweetBtn = UIButton()
        retweetBtn.setIcon(icon: .ionicons(.arrowReturnLeft), iconSize: CGFloat(25), color: .flatMint, forState: .normal)
        retweetBtn.addTarget(self, action: #selector(dissmiss), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [favBtn, retweetBtn, likeBtn])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        v.addSubview(stackView)
        
        stackView.snp.makeConstraints({ (make) in
            make.top.equalToSuperview().inset(8)
            make.right.equalToSuperview().inset(4)
            make.height.equalTo(30)
            make.width.equalToSuperview().multipliedBy(0.5)
        })
        
        let line = UIView()
        v.addSubview(line)
        line.backgroundColor = UIColor.lightGray
        line.snp.makeConstraints({ (make) in
            make.top.equalToSuperview().inset(45)
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
        })
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
        animateView()
        setupTableView()
    }
    
    func setupView(){
        
        // Add content view
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        view.addSubview(contentView)
        contentView.snp.makeConstraints({ (make) in
            make.width.equalToSuperview()
            make.height.equalTo(view.snp.height).inset(8)
            make.bottom.equalToSuperview().inset(-8)
            make.center.equalToSuperview()
        })

        
        view.isUserInteractionEnabled = true
        
    }
    
    func setupTableView(){
        tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = true
        tableView.emptyDataSetDelegate = self
        tableView.emptyDataSetDataSource = self
        tableView.register(TweetCell.self)
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        contentView.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(view.snp.height).inset(31)
            make.bottom.equalToSuperview().inset(0)
            make.center.equalToSuperview()
        }
    }
    
    func animateView(){
        contentView.alpha = 0;
        contentView.frame.origin.y = contentView.frame.origin.y + 77
        UIView.animate(withDuration: 0.8, animations: { () -> Void in
            self.contentView.alpha = 1.0;
            self.contentView.frame.origin.y = self.contentView.frame.origin.y - 77
        })
    }
    
  
    
    @objc func dissmiss(){
        let transition: CATransition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionReveal
        transition.subtype = kCATransition
        contentView.layer.add(transition, forKey: nil)
        self.dismiss(animated: false, completion: nil)
    }
    
}

extension ThreadVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fresh.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as TweetCell
        cell.tweet = ModelTweet()
        return cell
    }
}

extension ThreadVC: TBEmptyDataSetDelegate, TBEmptyDataSetDataSource {
    
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
