//
//  SSPPopUpAd.swift
//  sspadkit
//
//  Created by Dogus Yigit Ozcelik on 26.03.2021.
//

import Foundation
import UIKit
import WebKit

protocol SSPPopUpAdRequestProtocol  {
    func requestAd(handler: @escaping ((SSPPopUpAd) -> Void))
}

//extension SSPPopUpAdRequestProtocol  {
//    func requestAd(handler: @escaping ((SSPPopUpAd) -> Void)) {}
//}

public class SSPPopUpAd : NSObject, WKNavigationDelegate  {
    
    public var addId : Int?
    public let addresponse: AddResponse
    private var webView: WKWebView?
    private var closeButton: UIButton!
    private var popUpDelegate: PopUpAdDelegate
    private var config: SSPAdKitConfig
    private var instance: SSPPopUpAd?
    
    init(_addresponse: AddResponse, _popUpDelegate: PopUpAdDelegate, _config: SSPAdKitConfig, _identifier : Int? = nil) {
        self.addresponse = _addresponse
        self.popUpDelegate = _popUpDelegate
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
            
            if ((frame.width < CGFloat(self.config.adUnitSize?.adUnitWidth ?? 0)) || (frame.height < CGFloat(self.config.adUnitSize?.adUnitHeight ?? 0))) {
                self.popUpDelegate.failedToLoadAdd(forPopUp: self, reason: SSPResult.addContainerSizeIsNotCorrect)
                self.instance = nil
                return
            }
            
            let preferences = WKPreferences()
            preferences.javaScriptEnabled = true

            // Create a configuration for the preferences
            let configuration = WKWebViewConfiguration()
            configuration.preferences = preferences
            
            self.webView = WKWebView(frame: frame, configuration: configuration)
            self.webView?.navigationDelegate = self
            
            if let _ = self.webView, let _ad = self.addresponse.ad {
                self.popUpDelegate.addWillAppear?(forPopUp: self)
                view.addSubview(self.webView!)
                
                self.webView!.loadHTMLString(_ad, baseURL: nil)
                
                self.closeButton = UIButton(frame: CGRect(x: view.frame.width-40, y: 10, width: 30, height: 30))
                self.closeButton?.layer.cornerRadius = 15
                self.closeButton?.layer.borderWidth = 1
                self.closeButton.layer.borderColor = UIColor.black.cgColor
                self.closeButton?.backgroundColor = UIColor.white
                self.closeButton?.setTitle("X", for: .normal)
                self.closeButton?.setTitleColor(UIColor.black, for: .normal)
                self.closeButton?.showsTouchWhenHighlighted = true
                self.closeButton?.autoresizingMask = [.flexibleLeftMargin, .flexibleBottomMargin]
                
                view.addSubview(self.closeButton!)
                
                self.closeButton?.addTarget(self, action: #selector(self.closePopUpAction), for: .touchUpInside)
            } else {
                self.popUpDelegate.failedToLoadAdd(forPopUp: self, reason: SSPResult.addViewConstructorError)
                self.instance = nil
            }
        }
    }
    
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(.allow)
    }
    
    @objc public func closePopUpAction() {
        self.popUpDelegate.closePopUp(forPopUp: self)
        self.instance = nil
    }
    
}

public class SSPPopUpAdRequest : SSPPopUpAdRequestProtocol{
    
    var popUpAd: SSPPopUpAd?
    var config : SSPAdKitConfig
    var addSize: SSPAdContainerSize
    var popUpDelegate: PopUpAdDelegate
    var addId: Int?
    
    public init(_config: SSPAdKitConfig, _addSize: SSPAdContainerSize, _delegate: PopUpAdDelegate, _identifier : Int? = nil) {
        self.config = _config
        self.addSize = _addSize
        self.popUpDelegate = _delegate
        self.addId = _identifier
    }
    
}
