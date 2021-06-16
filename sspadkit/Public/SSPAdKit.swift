//
//  SSPAdKit.swift
//  sspadkit
//
//  Created by Dogus Yigit Ozcelik on 26.03.2021.
//

import Foundation
import UIKit

@objc public protocol BannerAdDelegate: NSObjectProtocol {
    
    func addReceived(forBanner adItem: SSPBannerAd)
    func failedToLoadAdd(forBanner adItem: SSPBannerAd, reason: SSPResult)
    
    @objc optional func addWillAppear(forBanner adItem: SSPBannerAd)
}

@objc public protocol PopUpAdDelegate: NSObjectProtocol {
    
    func addReceived(forPopUp adItem: SSPPopUpAd)
    func failedToLoadAdd(forPopUp adItem: SSPPopUpAd, reason: SSPResult)
    func closePopUp(forPopUp adItem: SSPPopUpAd)
    
    @objc optional func addWillAppear(forPopUp adItem: SSPPopUpAd)
}


public class SSPAdKit {
    
    public var config: SSPAdKitConfig
    public var bannerDelegate: BannerAdDelegate?
    public var popUpDelegate: PopUpAdDelegate?

    public init(_config: SSPAdKitConfig) {
        self.config = _config
    }

    
    public func requestBanner(for _size:SSPBannerSizes, _identifier : Int? = nil) -> SSPRequestResponse {
        if !(config.isInventoryIDValid) {
            debugPrint(SSPRequestResponse.sizeNotAvailableForDevice.enumDetails)
            return .sizeNotAvailableForDevice
        }
        if !(config.isInventoryIDValid) {
            debugPrint(SSPRequestResponse.sizeNotAvailableForDevice.enumDetails)
            return .sizeNotAvailableForDevice
        }
        let size = SSPAdContainerSize(_bannerSize: _size)
        if !(size.isValid) {
            debugPrint(SSPRequestResponse.sizeNotAvailableForDevice.enumDetails)
            return .sizeNotAvailableForDevice
        }
        if let bannerDelegate = bannerDelegate {
            let bannerReq = SSPBannerAdRequest(_config: config, _addSize: size, _delegate: bannerDelegate, _identifier: _identifier)
            bannerReq.requestAd(handler: { banner in
                if (banner.addresponse.succes == .succes) {
                    DispatchQueue.main.async {
                        bannerDelegate.addReceived(forBanner: banner)
                    }
                } else {
                    DispatchQueue.main.async {
                        bannerDelegate.failedToLoadAdd(forBanner: banner, reason: banner.addresponse.succes)
                    }
                }
            })
            debugPrint(SSPRequestResponse.succes.enumDetails)
            return .succes
        } else {
            debugPrint(SSPRequestResponse.delegateNotImplemented.enumDetails)
            return .delegateNotImplemented
        }
    }
    
    public func requestPopup(for _size:SSPPopUpSizes, _identifier : Int? = nil) -> SSPRequestResponse {
        if !(config.isInventoryIDValid) {
            debugPrint(SSPRequestResponse.sizeNotAvailableForDevice.enumDetails)
            return .sizeNotAvailableForDevice
        }
        if !(config.isInventoryIDValid) {
            debugPrint(SSPRequestResponse.sizeNotAvailableForDevice.enumDetails)
            return .sizeNotAvailableForDevice
        }
        let size = SSPAdContainerSize(_popUpSize: _size)
        if !(size.isValid) {
            debugPrint(SSPRequestResponse.sizeNotAvailableForDevice.enumDetails)
            return .sizeNotAvailableForDevice
        }
        if let popUpDelegate = popUpDelegate {
            let popUpReq = SSPPopUpAdRequest(_config: config, _addSize: size, _delegate: popUpDelegate, _identifier: _identifier)
            popUpReq.requestAd(handler: { popUp in
                if (popUp.addresponse.succes == .succes) {
                    DispatchQueue.main.async {
                        popUpDelegate.addReceived(forPopUp: popUp)
                    }
                } else {
                    DispatchQueue.main.async {
                        popUpDelegate.failedToLoadAdd(forPopUp: popUp, reason: popUp.addresponse.succes)
                    }
                }
            })
            debugPrint(SSPRequestResponse.succes.enumDetails)
            return .succes
        } else {
            debugPrint(SSPRequestResponse.delegateNotImplemented.enumDetails)
            return .delegateNotImplemented
        }
    }
}
