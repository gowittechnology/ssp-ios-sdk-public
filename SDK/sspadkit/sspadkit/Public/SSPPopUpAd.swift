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
    private var webView: WKWebView?
    private var containerView: UIView?
    private var closeButton: UIButton!
    private var addresponse: AddResponse
    private var popUpDelegate: PopUpAdDelegate
    
    init(_addresponse: AddResponse, _popUpDelegate: PopUpAdDelegate, _identifier : Int? = nil) {
        self.addresponse = _addresponse
        self.popUpDelegate = _popUpDelegate
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
                self.popUpDelegate.addWillAppear(forPopUp: self)
                self.containerView!.addSubview(self.webView!)
                
                self.webView!.loadHTMLString(_ad, baseURL: nil)
                
                self.closeButton = UIButton(frame: CGRect(x: self.containerView!.frame.width-100, y: 10, width: 100, height: 100))
                self.closeButton?.layer.cornerRadius = 15
                self.closeButton?.backgroundColor = UIColor.white
                self.closeButton?.setTitle("X", for: .normal)
                self.closeButton?.setTitleColor(UIColor.black, for: .normal)
                self.closeButton?.addTarget(self, action: #selector(self.crossButtonTapped(_:)), for: .touchUpInside)
                self.closeButton?.autoresizingMask = [.flexibleLeftMargin, .flexibleBottomMargin]
                
                self.containerView!.addSubview(self.closeButton!)
                
            }
        }
    }
    
    @objc func crossButtonTapped(_ sender: Any) {

        self.popUpDelegate.closePopUp(forPopUp: self)
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
