//
//  SSPBannerAd.swift
//  sspadkit
//
//  Created by Dogus Yigit Ozcelik on 26.03.2021.
//

import Foundation
import UIKit
import WebKit

public class SSPBannerAd : NSObject, WKNavigationDelegate {
    
    private var webView: WKWebView?
    private var request: URLRequest?
    private var containerView: UIView?
    
    public func show(in view: UIView) {
        self.containerView = view
        
        for item in view.subviews {
            item.removeFromSuperview()
        }
        
        let frame = CGRect(x: 0.0, y: 0.0, width: view.frame.width, height: view.frame.height)
        self.webView = WKWebView(frame: frame, configuration: WKWebViewConfiguration())
        self.webView?.navigationDelegate = self
        
        let url = URL(string: "https://www.google.com")
        self.request = (url == nil) ? nil : URLRequest(url: url!)
        if let _webView = self.webView, let _request = self.request {
            view.addSubview(_webView)
            _webView.load(_request)
        }
        
    }
    
}

public class SSPBannerAdRequest {
    
    private var bannerAd: SSPBannerAd?
    
    public func requestAd(handler: ((SSPBannerAd) -> Void)) {
        let banner = SSPBannerAd()
        handler(banner)
    }
}
