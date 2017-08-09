//
//  ProfileVC.swift
//  Thread Tweets
//
//  Created by Malcolm Kumwenda on 2017/08/04.
//  Copyright © 2017 mDevSA. All rights reserved.
//

import UIKit
import SnapKit
import SwiftIcons

class ProfileVC: UIViewController {
    
    var logInButton: TWTRLogInButton!
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if UserDefaults.standard.string(forKey: Strings.userID.rawValue) != nil {
            setupTableView()
        }else {
            setupLoginView()
        }
    }
    
    func setupLoginView() {
        logInButton = TWTRLogInButton(logInCompletion: { session, error in
            guard session != nil
                else {
                    print("error: \(error?.localizedDescription ?? "Houston we seem to have a problem.")")
                    return
            }
            guard let username = session?.userName,
                let userID = session?.userID else { return }
            UserDefaults.standard.set(userID, forKey: Strings.userID.rawValue)
            UserDefaults.standard.set(username, forKey: Strings.userName.rawValue)
            self.viewWillAppear(true)
        })
        
        view.addSubview(logInButton)
        logInButton.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.7)
            make.height.equalTo(45)
        }
    }
    
    func setupTableView() {
        // Add table
        tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = true
        tableView.register(ProfileCell.self)
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.height.width.equalToSuperview()
        }
        
        let header: UIView = {
            let v = UIView.init(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 120))
            v.backgroundColor = .red
            return v
        }()
        tableView.tableHeaderView = header
       
    }
    
}

extension ProfileVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        case 1:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as ProfileCell
        guard let userName = UserDefaults.standard.string(forKey: Strings.userName.rawValue) else {
            return UITableViewCell()
        }
        cell.label.text = userName
        cell.icon.image = UIImage.init(icon: .ionicons(.person), size: CGSize(width: 10, height: 10))
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return " "
    }
}
