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
    public let addresponse: AddResponse
    private var webView: WKWebView?
    private var bannerDelegate: BannerAdDelegate
    private var instance: SSPBannerAd?
    private var config: SSPAdKitConfig
    
    init(_addresponse: AddResponse, _bannerDelegate: BannerAdDelegate, _config: SSPAdKitConfig, _identifier : Int? = nil) {
        self.addresponse = _addresponse
        self.bannerDelegate = _bannerDelegate
        self.addId = _identifier
        self.config = _config
        super.init()
        self.instance = self
        
    }
    
    public func show(in view: UIView) {
        DispatchQueue.main.async {
            for item in view.subviews {
                item.removeFromSuperview()
            }
            
            let frame = CGRect(x: 0.0, y: 0.0, width: view.frame.width, height: view.frame.height)
            let scaledWidth = frame.width * UIScreen.main.scale
            let scaledHeight = frame.height * UIScreen.main.scale
            if ((scaledWidth < CGFloat(self.config.adUnitSize?.adUnitWidth ?? 0)) || (scaledHeight < CGFloat(self.config.adUnitSize?.adUnitHeight ?? 0))) {
                
                debugPrint("frame.width: \(frame.width) frame.height: \(frame.height)")
                debugPrint("scaled.width: \(scaledWidth) scaled.height: \(scaledHeight)")
                debugPrint("addUnit.width: \(self.config.adUnitSize?.adUnitWidth ?? 0) addUnit.height: \(self.config.adUnitSize?.adUnitHeight ?? 0)")
                
                self.bannerDelegate.failedToLoadAdd(forBanner: self, reason: SSPResult.addContainerSizeIsNotCorrect)
                self.instance = nil
                return
            }
            
            self.webView = WKWebView(frame: frame, configuration: WKWebViewConfiguration())
            self.webView?.navigationDelegate = self
            
            if let _ = self.webView, let _ad = self.addresponse.ad {
                self.bannerDelegate.addWillAppear?(forBanner: self)
                view.addSubview(self.webView!)
                self.webView!.loadHTMLString(_ad, baseURL: nil)
            } else {
                self.bannerDelegate.failedToLoadAdd(forBanner: self, reason: SSPResult.addViewConstructorError)
                self.instance = nil
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
