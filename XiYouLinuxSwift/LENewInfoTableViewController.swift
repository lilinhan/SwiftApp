//
//  LENewInfoTableViewController.swift
//  XiYouLinuxSwift
//
//  Created by lewin丶 on 2017/5/4.
//  Copyright © 2017年 lewin丶. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import Kingfisher

class LENewInfoTableViewController: UITableViewController {
    var id:Int32?
    var data:LEData?
    
    let cellid = "commentcell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getNewInfoDataFromWeb()
        tableView.scrollIndicatorInsets = UIEdgeInsets.init(top: 5, left: 0, bottom: 0, right: 0)
        tableView.register(LECommentTableViewCell.self, forCellReuseIdentifier: cellid)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }

}

//MARK: 设置uitabview的代理和数据源
extension LENewInfoTableViewController {
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard (self.data?.comments?.count) != nil else {
            return 0
        }
        
        return (self.data?.comments?.count)!
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        var cell = tableView.dequeueReusableCell(withIdentifier: cellid) as? LECommentTableViewCell
        if cell == nil {
            cell = LECommentTableViewCell.init(style: .default, reuseIdentifier: cellid)
        }
        if let iconString = self.data?.comments?[indexPath.row].author?.avatar_url {
            let url = URL(string: iconString)
            cell?.icon.kf.setImage(with: url)
        }
        cell?.nameLabel.text = self.data?.comments?[indexPath.row].author?.name
        cell?.commentLabel.text = self.data?.comments?[indexPath.row].content
        cell?.timeLabel.text = self.data?.comments?[indexPath.row].created_at
        return cell!
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}


// MARK:  从网络中获取数据
extension LENewInfoTableViewController {
    func getNewInfoDataFromWeb()  {
        let accessToken = UserDefaults.standard.value(forKey: "LiAccessToken") as! String
        let urlString = "https://api.xiyoulinux.org/news/" + "\(id!)"
        //print("url:\(urlString)")
        let url = URL(string: urlString)
        let params = ["access_token":accessToken]
        
        Alamofire.request(url!, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil).responseString { (response) in
            if response.result.isSuccess {
                let data = Mapper<LEData>().map(JSONString: response.value!)
                self.data = data
                let header = LENewDataInfoHeader()
                header.frame = CGRect(x: 0, y: 0, width: screenW - 2*margin, height: 200)
                if let iconString = self.data?.author?.avatar_url {
                    let url = URL(string: iconString)
                    header.icon.kf.setImage(with: url)
                }
                header.name.text = self.data?.author?.name
                header.timeLabel.text = (self.data?.created_at)!
                header.contentLabe.text = self.data?.content
                
                self.tableView.tableHeaderView = header
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            
            if response.result.isFailure {
                print("Network is Error")
            }
        }
    }

    
}
