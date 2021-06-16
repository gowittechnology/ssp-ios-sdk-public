//
//  SSPBannerAdRequest+Extensions.swift
//  sspadkit
//
//  Created by Dogus Yigit Ozcelik on 16.06.2021.
//

import Foundation

extension SSPBannerAdRequest {
    
    func requestAd(handler: @escaping ((SSPBannerAd) -> Void)) {
        self.config.adUnitSize = addSize
        let params = self.config.getBannerParams()
        debugPrint("Banner request params: \(params)")
        let networkHelper = NetworkHelper()
        networkHelper.timeOutInterval = max((config.addTimeOutInterval ?? 30), 30)
        networkHelper.requestBanner(params: params, handler: { data in
            let banner = SSPBannerAd(_addresponse: data, _bannerDelegate: self.bannerDelegate,  _config: self.config, _identifier: self.addId)
            handler(banner)
        })
    }
    
}


