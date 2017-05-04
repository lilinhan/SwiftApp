//
//  LELoginTViewController.swift
//  XiYouLinuxSwift
//
//  Created by lewin丶 on 2017/4/26.
//  Copyright © 2017年 lewin丶. All rights reserved.
//

import UIKit
import OAuthSwift

class LELoginTViewController: OAuthViewController {
    var oauthswift: OAuthSwift?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startAuthorization()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func startAuthorization()  {
//        let random = arc4random()
        
        let oauthswift = OAuth2Swift(
            consumerKey: "XiyouLinuxApp",
            consumerSecret: "$2y$10$tk7eahucEo0xJnE9r3GJ5uwuD/pKMReWx",
            authorizeUrl: "https://sso.xiyoulinux.org/oauth/authorize",
            accessTokenUrl: "https://sso.xiyoulinux.org/oauth/access_token",
            responseType: "code")
        
        self.oauthswift = oauthswift
        oauthswift.authorizeURLHandler = OAuthSwiftOpenURLExternally.sharedInstance
        let state = generateState(withLength: 20)
        
        
        oauthswift.authorize(
            withCallbackURL: URL(string: "https://www.app.xiyoulinux.org/")!,
            scope: "all",
            state: state,
            success: { (credential, response, parameters) in
                print(credential.oauthToken)
        }) { (error) in
            print(error)
        }
    }
    

    
}


class WebViewController: OAuthWebViewController, UIWebViewDelegate {
    var targetUrl:URL?
    var webView:UIWebView?
    
    override func viewDidLoad() {
        webView = UIWebView()
        webView?.frame = self.view.bounds
        webView?.autoresizingMask = UIViewAutoresizing.flexibleHeight
        webView?.scalesPageToFit = true
        webView?.delegate = self
        view.addSubview(webView!)
        loadAddress()
        //quitWebView()
    }
    
    override func handle(_ url: URL) {
        targetUrl = url
        super.handle(url)
        loadAddress()
    }
    
    func loadAddress()  {
        guard let url = targetUrl else {
            return
        }

        let req = URLRequest(url: url)
        webView?.loadRequest(req)
    }
    
    func quitWebView()  {
        let url = "https://sso.xiyoulinux.org/logout"
        let request = URLRequest(url: URL(string: url)!)
        
        webView?.loadRequest(request)
        print("Quit Done")
        
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if let url = request.url, url.scheme == "oauth-swift" {
            self.dismissWebViewController()
        }
        return true
    }
}
