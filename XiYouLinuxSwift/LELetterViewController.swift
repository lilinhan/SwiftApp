//
//  LELetterViewController.swift
//  XiYouLinuxSwift
//
//  Created by lewin丶 on 2017/5/6.
//  Copyright © 2017年 lewin丶. All rights reserved.
//

import UIKit

class LELetterViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "写信", style: .plain, target: self, action: #selector(createSendMessageVC))
    }

    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
}

//MARK: 创建写消息的vc
extension LELetterViewController {
    func createSendMessageVC()  {
        let vc = LESendMessageViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        self.tabBarController?.tabBar.isHidden = true
    }
}


// MARK: - Table view data source
extension LELetterViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        // Configure the cell...
        
        return cell
    }
    

}
