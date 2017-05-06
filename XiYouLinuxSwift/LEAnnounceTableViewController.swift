//
//  LEAnnounceTableViewController.swift
//  XiYouLinuxSwift
//
//  Created by lewin丶 on 2017/2/12.
//  Copyright © 2017年 lewin丶. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher
import SwiftyJSON
import ObjectMapper

class LEAnnounceTableViewController: UITableViewController {
    var data = [LEData]()
    
    let cellid = "Annocell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDataFromWeb()
        tableView.scrollIndicatorInsets = UIEdgeInsets.init(top: 5, left: 0, bottom: 0, right: 0)
        tableView.register(LEAnnoTableViewCell.self, forCellReuseIdentifier: cellid)
    }

}

extension LEAnnounceTableViewController {
    func getDataFromWeb()  {
        let accessToken = UserDefaults.standard.value(forKey: "LiAccessToken") as! String
        let urlString = "https://api.xiyoulinux.org/news/"
        print("url:\(urlString)")
        let url = URL(string: urlString)
        let params = ["access_token":accessToken]
        
        Alamofire.request(url!, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil).responseString { (response) in
            if response.result.isSuccess {
                var json = JSON(parseJSON: response.result.value!)
                json = json["data"]
                for (_,value) in json {
                    if value["type"].int == 1 {
                        let data = Mapper<LEData>().map(JSONString: value.rawString()!)
                        self.data.append(data!)
                        
                    }
                }
                
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

// MARK: - Table view data source
extension LEAnnounceTableViewController {
       override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (self.data.count)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellid) as? LEAnnoTableViewCell
        
        if cell == nil {
            cell = LEAnnoTableViewCell.init(style: .default, reuseIdentifier: cellid)
        }
        cell?.selectionStyle = .none
        if data.count > 0 {
            print(data.count)
            cell?.nameLabel.text = data[indexPath.row].author?.name
            
            if let iconString = data[indexPath.row].author?.avatar_url {
                let url = URL(string: iconString)
                cell?.iconView.kf.setImage(with: url)
            }
            
            cell?.timeLabel.text = data[indexPath.row].created_at
            cell?.contentLabel.text = data[indexPath.row].content
        }
        
        return cell!
    }
    
}
