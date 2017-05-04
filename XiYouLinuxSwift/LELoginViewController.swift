//
//  LELoginViewController.swift
//  XiYouLinuxSwift
//
//  Created by lewin丶 on 2017/4/26.
//  Copyright © 2017年 lewin丶. All rights reserved.
//

import UIKit
import Alamofire

class LELoginViewController: UIViewController , UIWebViewDelegate{
    var webView: UIWebView?
    
    let client_id = "XiyouLinuxApp"
    let secretKey = "$2y$10$tk7eahucEo0xJnE9r3GJ5uwuD/pKMReWx"
    let authorizationEndPoint = "https://sso.xiyoulinux.org/oauth/authorize"
    let accessTokenEndPoint = "https://sso.xiyoulinux.org/oauth/access_token"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView = UIWebView()
        webView?.frame = CGRect(x: 0, y: 0, width: screenW, height: screenH)
        self.view.addSubview(webView!)
        webView?.delegate = self
        
        startAuthorization()
        //quitWebView()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //退出webview
    func quitWebView()  {
        let url = "https://sso.xiyoulinux.org/logout"
        let request = URLRequest(url: URL(string: url)!)
        
        let accessToken = ""
        
        UserDefaults.standard.setValue(accessToken, forKey: "LiAccessToken")
        UserDefaults.standard.synchronize()
        
        webView?.loadRequest(request)
        print("Quit Done")
        
    }

    //MARK:  开始解析
    func startAuthorization()  {
        //随机一个数  作为state的值
        let random = arc4random()
        
        let response_type = "code"
        let redirect_uri = "https://www.app.xiyoulinux.org/".addingPercentEncoding(withAllowedCharacters: NSCharacterSet.alphanumerics)!
        let state = String(random)
        let scope = "all"
        
        var authorizationURL = "\(authorizationEndPoint)?"
        authorizationURL += "response_type=\(response_type)&"
        authorizationURL += "client_id=\(client_id)&"
        authorizationURL += "redirect_uri=\(redirect_uri)&"
        authorizationURL += "state=\(state)&"
        authorizationURL += "scope=\(scope)"
        
        
        let request = URLRequest(url: URL(string: authorizationURL)!)
        webView?.loadRequest(request)
    
    }
    //webview 的代理   用来监控访问的请求
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        let url = request.url!
        print("URL:\(url)")
        
        if url.host == "www.app.xiyoulinux.org" {
            if url.absoluteString.range(of: "code") != nil {
                let urlPath = url.absoluteString.components(separatedBy: "?")
                var code = urlPath[1].components(separatedBy: "=")[1]
                let start = code.index(code.startIndex, offsetBy: 40)
                code = code.substring(to: start)
//                print("code:\(code)")
                
                requestForAccessToken(authorizationCode: code)
            }
        }
        
        
        return true
    }
    
    //MARK: 获取Token
    func requestForAccessToken(authorizationCode: String)  {
        let grant_type = "authorization_code"
        let redirect_uri = "https://www.app.xiyoulinux.org/".addingPercentEncoding(withAllowedCharacters: NSCharacterSet.alphanumerics)!
        
        var postParams = "grant_type=\(grant_type)&"
        postParams += "code=\(authorizationCode)&"
        postParams += "redirect_uri=\(redirect_uri)&"
        postParams += "client_id=\(client_id)&"
        postParams += "client_secret=\(secretKey)"
        
        let postData = postParams.data(using: .utf8)
        let request = NSMutableURLRequest(url: URL(string: accessTokenEndPoint)!)
        
        request.httpMethod = "POST"
        request.httpBody = postData
        
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            let statusCode = (response as! HTTPURLResponse).statusCode
//            print("status code is \(statusCode)")
            if statusCode == 201 {
                // 将 JSON 数据转换成字典
                do {
                    let dataDictionary = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String: AnyObject]
                    
                    let accessToken = dataDictionary["access_token"] as! String
//                    print(accessToken)
                    
                    //access token 持久化
                    UserDefaults.standard.setValue(accessToken, forKey: "LiAccessToken")
                    UserDefaults.standard.synchronize()
                    
                    DispatchQueue.main.async {
//                        let token = UserDefaults.standard.value(forKey: "LiAccessToken") as! String
//                        print("Token is \(token)")
                        self.dismiss(animated: true, completion: nil)
                    }
                    
                    //可以关闭login页面
                }
                catch {
                    print("Could not convert JSON data into a dictionary.")
                }
            }
        }
        
        task.resume()
        
    }

}
