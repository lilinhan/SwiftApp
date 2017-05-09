//
//  MainViewController.swift
//  XiYouLinuxSwift
//
//  Created by lewin丶 on 2017/2/11.
//  Copyright © 2017年 lewin丶. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class MainViewController: UITabBarController {

    override func viewDidAppear(_ animated: Bool) {
        //如果是第一次登陆
        //let accessToken = ""
        //UserDefaults.standard.setValue(accessToken, forKey: "LiAccessToken")

        let accessToken = UserDefaults.standard.value(forKey: "LiAccessToken") as! String
        if accessToken == "" || accessToken.characters.count <= 0{
            let loginVC = LELoginViewController()
            self.present(loginVC, animated: true, completion: nil)
            print("First Time Login")
        }else {
            //print("accessToken\(accessToken)")
            let params:Parameters = ["access_token":accessToken]
            print(params)
            //判断access token 是否已经过期   采用请求自己的个人信息来做
            //如果过期返回failure   成功返回success
            Alamofire.request(URL(string: "https://api.xiyoulinux.org/me")!, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
                if response.result.isSuccess {
                    let json = JSON(response.result.value!)
                    if json.first?.0 == "error" {
                        print("Token 失效")
                        let loginVC = LELoginViewController()
                        self.present(loginVC, animated: true, completion: nil)
                    }
                    print("login succ")
                }
                
                if response.result.isFailure {
                    print("Token 获取失败")
                    let loginVC = LELoginViewController()
                    self.present(loginVC, animated: true, completion: nil)
                    
                }
            }
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        automaticallyAdjustsScrollViewInsets = false
        setAllChildController()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //设置所有的子控制器
    func setAllChildController()  {
        //需要创建tabbar button 和  选中的 tabbar button
        let newsVC = LENewsTableViewController(style: .plain)
        let nav1 = UINavigationController(rootViewController: newsVC)
        nav1.view.backgroundColor = UIColor.white
        nav1.tabBarItem.title = "新鲜事"
        newsVC.title = nav1.tabBarItem.title
        nav1.tabBarItem.image = UIImage(named: "news_tab_n")
        nav1.tabBarItem.selectedImage = UIImage(named: "news_tab_h")
        self.addChildViewController(nav1)
        
        let announceVC = LEAnnounceTableViewController(style: .plain)
        let nav2 = UINavigationController(rootViewController: announceVC)
        nav2.view.backgroundColor = UIColor.white
        nav2.tabBarItem.title = "公告"
        announceVC.title = nav2.tabBarItem.title
        nav2.tabBarItem.image = UIImage(named: "announce_tab_n")
        nav2.tabBarItem.selectedImage = UIImage(named: "announce_tab_h")
        self.addChildViewController(nav2)
        
        let letterVC = LELetterViewController()
        let nav3 = UINavigationController(rootViewController: letterVC)
        nav3.view.backgroundColor = UIColor.white
        nav3.tabBarItem.title = "站内信"
        letterVC.title = nav3.tabBarItem.title
        nav3.tabBarItem.image = UIImage(named: "letter_tab_n")
        nav3.tabBarItem.selectedImage = UIImage(named: "letter_tab_h")
        self.addChildViewController(nav3)
        
        let reportVC = LEReportViewController()
        let nav4 = UINavigationController(rootViewController: reportVC)
        nav4.view.backgroundColor = UIColor.white
        nav4.tabBarItem.title = "反馈"
        reportVC.title = nav4.tabBarItem.title
        nav4.tabBarItem.image = UIImage(named: "report_tab_n")
        nav4.tabBarItem.selectedImage = UIImage(named: "report_tab_h")
        self.addChildViewController(nav4)
        
        let meVC = LEMeViewController()
        let nav5 = UINavigationController(rootViewController: meVC)
        nav5.view.backgroundColor = UIColor.white
        nav5.tabBarItem.title = "个人信息"
        meVC.title = nav5.tabBarItem.title
        nav5.tabBarItem.image = UIImage(named: "me_tab_n")
        nav5.tabBarItem.selectedImage = UIImage(named: "me_tab_h")

        self.addChildViewController(nav5)
    }

    
}
