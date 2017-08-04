//
//  ThreadsTVC.swift
//  Thread Tweets
//
//  Created by Malcolm Kumwenda on 2017/08/04.
//  Copyright © 2017 mDevSA. All rights reserved.
//

import UIKit

class ThreadsTVC: UITableViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        cell.textLabel!.text = "foo"
        return cell
    }

}
