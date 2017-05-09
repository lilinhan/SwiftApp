//
//  LEMemTableViewController.swift
//  XiYouLinuxSwift
//
//  Created by lewin丶 on 2017/5/7.
//  Copyright © 2017年 lewin丶. All rights reserved.
//

import UIKit
import ESPullToRefresh
import Alamofire
import SwiftyJSON
import ObjectMapper
import Kingfisher

protocol MyProtocol {
    func passUserId(id: Int, name:String)
}

class LEMemTableViewController: UITableViewController {
    let cellid = "Memberid"
    var delegate:MyProtocol?
    var data = [LEPeople]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDataFromWeb()
        self.tableView.register(LEMemTableViewCell.self, forCellReuseIdentifier: cellid)
    }
}

//网络部分
extension LEMemTableViewController {
    func getDataFromWeb()  {
        let urlString = "https://api.xiyoulinux.org/users"
        let url = URL(string: urlString)
        let accessToken = UserDefaults.standard.value(forKey: "LiAccessToken") as! String

        let params = ["access_token":accessToken, "page":1, "per_page":400] as [String : Any]
        
        Alamofire.request(url!, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil).responseString { (response) in
            if response.result.isSuccess {
                var json = JSON(parseJSON: response.result.value!)
                json = json["data"]
                for (_,value) in json {
                    let person = Mapper<LEPeople>().map(JSONString: value.rawString()!)
                    self.data.append(person!)
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            
            if response.result.isFailure {
                print("网络异常")
            }
        }
    }
}

// MARK: - Table view data source
extension LEMemTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellid) as? LEMemTableViewCell
        
        if cell == nil {
            cell = LEMemTableViewCell.init(style: .default, reuseIdentifier: cellid)
        }
        
        if data.count > 0 {
            cell?.nameLabel.text = data[indexPath.row].name!
            
            if let iconString = data[indexPath.row].avatar_url {
                let url = URL(string: iconString)
                cell?.iconView.kf.setImage(with: url)
            }
        }
        
        return cell!
    }
}

//页面传值
extension LEMemTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = LESendMessageViewController()
//        delegate = vc
        delegate?.passUserId(id: Int(exactly: data[indexPath.row].id!)!, name: data[indexPath.row].name!)
        
        _ = self.navigationController?.popViewController(animated: true)
    }

}



