//
//  TweetCell.swift
//  Thread Tweets
//
//  Created by Malcolm Kumwenda on 2017/08/06.
//  Copyright © 2017 mDevSA. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    var tweet: ModelTweet? {
        didSet {
            setupUI()
        }
    }
    
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userHandle: UILabel!
    @IBOutlet weak var iconImg: UIImageView!
    @IBOutlet weak var post: UILabel!
    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var footerView: UIView!
    
    fileprivate func setupUI(){
        selectionStyle = .none
        profileImg.layer.cornerRadius = 40/2
        profileImg.clipsToBounds = true
        profileImg.image = #imageLiteral(resourceName: "me")
        iconImg.image = UIImage.init(icon: .ionicons(.socialTwitter), size: CGSize(width: 20, height: 20), textColor: .flatSkyBlue, backgroundColor: .clear)
        postImg.layer.cornerRadius = 3
        
        setupFooter()
    }
    
    fileprivate func setupFooter() {
        let favBtn = UIButton()
        favBtn.setIcon(icon: .ionicons(.bookmark), iconSize: CGFloat(18), color: .flatBlack, forState: .normal)
        favBtn.addTarget(self, action: #selector(dissmiss), for: .touchUpInside)
        
        let likeBtn = UIButton()
        likeBtn.setIcon(icon: .ionicons(.iosHeart), iconSize: CGFloat(18), color: .flatBlack, forState: .normal)
        likeBtn.addTarget(self, action: #selector(dissmiss), for: .touchUpInside)
        
        let retweetBtn = UIButton()
        retweetBtn.setIcon(icon: .ionicons(.arrowReturnLeft), iconSize: CGFloat(18), color: .flatBlack, forState: .normal)
        retweetBtn.addTarget(self, action: #selector(dissmiss), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [favBtn, retweetBtn, likeBtn])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        footerView.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    @objc func dissmiss(){
        
    }
}
