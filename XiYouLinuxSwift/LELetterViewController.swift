//
//  LELetterViewController.swift
//  XiYouLinuxSwift
//
//  Created by lewin丶 on 2017/5/6.
//  Copyright © 2017年 lewin丶. All rights reserved.
//

import UIKit
import ESPullToRefresh
import Alamofire
import SwiftyJSON
import ObjectMapper
import Kingfisher

class LELetterViewController: UITableViewController {
    var data = [LEMessage]()
    var page = 1
    
    let cellid = "messageid"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDataFromWeb()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "写信", style: .plain, target: self, action: #selector(createSendMessageVC))
        tableView.register(LEMessageTableViewCell.self, forCellReuseIdentifier: cellid)
        
        self.tableView.es_addPullToRefresh {
            [weak self] in
            /// 在这里做刷新相关事件
            /// ...
            self?.page = 1
            self?.getDataFromWeb()
            /// 如果你的刷新事件成功，设置completion自动重置footer的状态
            self?.tableView.es_stopPullToRefresh(ignoreDate: true)
            /// 设置ignoreFooter来处理不需要显示footer的情况
            self?.tableView.es_stopPullToRefresh(ignoreDate: true, ignoreFooter: false)
        }
        tableView.es_addInfiniteScrolling {
            [weak self] in
            /// 在这里做加载更多相关事件
            /// ...
            self?.getDataFromWeb()
            /// 如果你的加载更多事件成功，调用es_stopLoadingMore()重置footer状态
            self?.tableView.es_stopLoadingMore()
            /// 通过es_noticeNoMoreData()设置footer暂无数据状态
            self?.tableView.es_noticeNoMoreData()
        }
        
    }

    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
}

//MARK: 网络请求
extension LELetterViewController {
    func getDataFromWeb()  {
        let accessToken = UserDefaults.standard.value(forKey: "LiAccessToken") as! String
        let url = URL(string: "https://api.xiyoulinux.org/messages")
        
        let params = ["per_page":20, "access_token":accessToken, "page":page] as [String : Any]
        Alamofire.request(url!, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil).responseString { (response) in
            if response.result.isSuccess {
                var json = JSON(parseJSON: response.result.value!)
                json = json["data"]
                
                if self.page == 1 {
                    self.data.removeAll()
                }
                
                for (_,value) in json {
                    let data = Mapper<LEMessage>().map(JSONString: value.rawString()!)
                    self.data.append(data!)
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            
            if response.result.isFailure {
                print(response.error!)
            }
            self.page += 1
        }
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
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellid) as? LEMessageTableViewCell
        
        if cell == nil {
            cell = LEMessageTableViewCell.init(style: .default, reuseIdentifier: cellid)
        }
        cell?.selectionStyle = .none
        if data.count > 0 {
            if let iconString = data[indexPath.row].author?.avatar_url {
                let url = URL(string: iconString)
                cell?.iconView.kf.setImage(with: url)
            }
            cell?.nameLabel.text = data[indexPath.row].author?.name
            cell?.timeLabel.text = data[indexPath.row].created_at
            cell?.contentLabel.text = data[indexPath.row].content
        }
        return cell!
    }
    

}
