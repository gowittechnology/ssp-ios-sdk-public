//
//  SSPBannerAd.swift
//  sspadkit
//
//  Created by Dogus Yigit Ozcelik on 26.03.2021.
//

import Foundation
import UIKit
import WebKit

protocol SSPBannerAdRequestProtocol  {
    func requestAd(handler: @escaping ((SSPBannerAd) -> Void))
}

//extension SSPBannerAdRequestProtocol  {
//    func requestAd(handler: @escaping ((SSPBannerAd) -> Void)) {}
//}

public class SSPBannerAd : NSObject, WKNavigationDelegate {
    
    public var addId : Int?
    private var webView: WKWebView?
    private var containerView: UIView?
    private var addresponse: AddResponse
    private var bannerDelegate: BannerAdDelegate
    
    init(_addresponse: AddResponse, _bannerDelegate: BannerAdDelegate, _identifier : Int? = nil) {
        self.addresponse = _addresponse
        self.bannerDelegate = _bannerDelegate
        self.addId = _identifier
    }
    
    public func show(in view: UIView) {
        DispatchQueue.main.async {
            self.containerView = view
            
            for item in view.subviews {
                item.removeFromSuperview()
            }
            
            let frame = CGRect(x: 0.0, y: 0.0, width: view.frame.width, height: view.frame.height)
            self.webView = WKWebView(frame: frame, configuration: WKWebViewConfiguration())
            self.webView?.navigationDelegate = self
            
            if let _webView = self.webView, let _ad = self.addresponse.ad {
                self.bannerDelegate.addWillAppear(forBanner: self)
                view.addSubview(_webView)
                _webView.loadHTMLString(_ad, baseURL: nil)
            }
        }
        
    }
    
}

public class SSPBannerAdRequest : SSPBannerAdRequestProtocol {
    

    var bannerAd: SSPBannerAd?
    var config : SSPAdKitConfig
    var addSize: SSPAdContainerSize
    var bannerDelegate: BannerAdDelegate
    var addId: Int?
    
    public init(_config: SSPAdKitConfig, _addSize: SSPAdContainerSize, _delegate: BannerAdDelegate, _identifier : Int? = nil) {
        self.config = _config
        self.addSize = _addSize
        self.bannerDelegate = _delegate
        self.addId = _identifier
    }
}
