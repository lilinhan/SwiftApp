//
//  LENewsTableViewController.swift
//  XiYouLinuxSwift
//
//  Created by lewin丶 on 2017/2/12.
//  Copyright © 2017年 lewin丶. All rights reserved.
//

import UIKit
import ESPullToRefresh
import Alamofire
import SwiftyJSON
import ObjectMapper
import Kingfisher

class LENewsTableViewController: UITableViewController {
    
    var page = 1
    var data:LENewData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDataFromWeb()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.scrollIndicatorInsets = UIEdgeInsets.init(top: 5, left: 0, bottom: 0, right: 0)
        //设置透明度
        self.navigationController?.navigationBar.isTranslucent = false
        
        self.tableView.es_addPullToRefresh {
            [weak self] in
            /// 在这里做刷新相关事件
            /// ...
            self?.page = 1;

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
        setNavBarButtonIterm()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        getDataFromWeb()
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    func setNavBarButtonIterm()  {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发表", style: .plain, target: self, action: #selector(pressBtn))
        
    }
    
    func pressBtn()  {
        let vc = LEPublishViewController()
        //type:1  发表新鲜事 type:2 发表评论
        vc.type = 1
        self.navigationController?.pushViewController(vc, animated: true)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func pressLikeBtn(btn: UIButton)  {
        let urlString = "https://api.xiyoulinux.org/news/\(btn.tag)/favors"
        let url = URL(string: urlString)
        let accessToken = UserDefaults.standard.value(forKey: "LiAccessToken") as! String
        
        let param = ["access_token":accessToken]
        
        
        Alamofire.request(url!, method: .post, parameters: param, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            if response.result.isSuccess {
                var num:Int = Int((btn.titleLabel?.text)!)!
                num += 1
                let str = "\(num)"
                btn.setTitle(str, for: .normal)
                btn.setTitle(str, for: .highlighted)
            }
            
            if response.result.isFailure {
                print("Network Error")
            }
        }
        
    }
    
    func pressCommentBtn(btn: UIButton)  {
        let id = btn.tag
        let vc = LEPublishViewController()
        //type:1  发表新鲜事 type:2 发表评论
        vc.type = 2
        vc.id = id
        self.navigationController?.pushViewController(vc, animated: true)
        self.tabBarController?.tabBar.isHidden = true
        
    }
}

//MARK:  从网络获取数据
extension LENewsTableViewController {
    func getDataFromWeb()  {
        let accessToken = UserDefaults.standard.value(forKey: "LiAccessToken") as! String
        let url = URL(string: "https://api.xiyoulinux.org/news")
        
        let params = ["per_page":10, "access_token":accessToken, "page":page] as [String : Any]
        Alamofire.request(url!, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil).responseString { (response) in
            if response.result.isSuccess {
                let data = Mapper<LENewData>().map(JSONString: response.value!)
                
                if self.page == 1 {
                    self.data = data
                }else {
                    for value in (data?.data)! {
                        self.data?.data?.append(value)
                    }
                }
                
                self.tableView.reloadData()
            }
            
            if response.result.isFailure {
                print(response.error!)
            }
            self.page += 1
        }
    }
    
}

extension LENewsTableViewController {
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard (self.data?.data?.count) != nil else {
            return 5
        }
        return (self.data?.data?.count)!
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "cell"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID) as? LENewTableViewCell
        if cell == nil {
            cell = LENewTableViewCell.init(style: .default, reuseIdentifier: cellID)
        }
        //给cell赋值
        cell?.nameLabel?.text = self.data?.data?[indexPath.row].author?.name
        if let iconString = self.data?.data?[indexPath.row].author?.avatar_url {
            let url = URL(string: iconString)
            cell?.iconView?.kf.setImage(with: url)
        }
        cell?.contentLabel?.text = self.data?.data?[indexPath.row].content
        cell?.timeLabel?.text = self.data?.data?[indexPath.row].created_at
        
        
        if let likeBtnLabelNum = self.data?.data?[indexPath.row].favors?.count {
            let likeBtnLabel = "\(likeBtnLabelNum)"
            cell?.likeBtn?.setTitle(likeBtnLabel, for: .normal)
            cell?.likeBtn?.setTitle(likeBtnLabel, for: .highlighted)
            cell?.likeBtn?.tag = Int(exactly: (self.data?.data?[indexPath.row].id)!)!
            cell?.likeBtn?.addTarget(self, action: #selector(pressLikeBtn(btn:)), for: .touchUpInside)
        }
        
        if let commentBtnLabelNum = self.data?.data?[indexPath.row].comments?.count {
            let commentBtnLabel = "\(commentBtnLabelNum)"
            cell?.commentBtn?.setTitle(commentBtnLabel, for: .normal)
            cell?.commentBtn?.setTitle(commentBtnLabel, for: .highlighted)
            cell?.commentBtn?.tag = Int(exactly: (self.data?.data?[indexPath.row].id)!)!
            cell?.commentBtn?.addTarget(self, action: #selector(pressCommentBtn(btn:)), for: .touchUpInside)
        }
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newInfoPage = LENewInfoTableViewController()
        newInfoPage.id = self.data?.data?[indexPath.row].id
        self.navigationController?.pushViewController(newInfoPage, animated: true)
        
    }
    
}
