//
//  SSPAdKit.swift
//  sspadkit
//
//  Created by Dogus Yigit Ozcelik on 26.03.2021.
//

import Foundation
import UIKit

public protocol BannerAdDelegate: NSObjectProtocol {
    func addReceived(forBanner adItem: SSPBannerAd)
    func addWillAppear(forBanner adItem: SSPBannerAd)
}

public protocol PopUpAdDelegate: NSObjectProtocol {
    func addReceived(forPopUp adItem: SSPPopUpAd)
    func addWillAppear(forPopUp adItem: SSPPopUpAd)
    func closePopUp(forPopUp adItem: SSPPopUpAd)
}

public enum SSPRequestResponse : Int {
    case succes =  0
    case internalError
    case delegateNotImplemented
    case containerNotSuitable
}

struct AddResponse {
    let succes : Bool
    let error : String?
    let ad: String?
    let width : Int?
    let height : Int?
    let billable : String?
}

public class SSPAdKit {
    
    public var config: SSPAdKitConfig
    public var bannerDelegate: BannerAdDelegate?
    public var popUpDelegate: PopUpAdDelegate?

    public init(_config: SSPAdKitConfig) {
        self.config = _config
    }

    
    public func requestBanner(for size:SSPAdContainerSize, _identifier : Int? = nil) -> SSPRequestResponse {
        if let bannerDelegate = bannerDelegate {
            let bannerReq = SSPBannerAdRequest(_config: config, _addSize: size, _delegate: bannerDelegate, _identifier: _identifier)
            bannerReq.requestAd(handler: { banner in
                DispatchQueue.main.async {
                    bannerDelegate.addReceived(forBanner: banner)
                    
                }
            })
            return .succes
        } else {
            return .delegateNotImplemented
        }
    }
    
    public func requestPopup(for size:SSPAdContainerSize, _identifier : Int? = nil) -> SSPRequestResponse {
        if let popUpDelegate = popUpDelegate {
            let popUpReq = SSPPopUpAdRequest(_config: config, _addSize: size, _delegate: popUpDelegate, _identifier: _identifier)
            popUpReq.requestAd(handler: { popUp in
                DispatchQueue.main.async {
                    popUpDelegate.addReceived(forPopUp: popUp)
                    
                }
            })
            return .succes
        } else {
            return .delegateNotImplemented
        }
    }
}
