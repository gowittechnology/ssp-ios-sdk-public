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
        let networkHelper = NetworkHelper()
        networkHelper.requestBanner(params: params, handler: { data in
            let banner = SSPBannerAd(_addresponse: data, _bannerDelegate: self.bannerDelegate, _identifier: self.addId)
            handler(banner)
        })
    }
    
}


