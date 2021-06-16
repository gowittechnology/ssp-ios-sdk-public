//
//  SSPPopUpAdRequest+Extensions.swift
//  sspadkit
//
//  Created by Dogus Yigit Ozcelik on 16.06.2021.
//

import Foundation


import Foundation

extension SSPPopUpAdRequest {
    
    func requestAd(handler: @escaping ((SSPPopUpAd) -> Void)) {
        self.config.adUnitSize = addSize
        let params = self.config.getPopUpParams()
        let networkHelper = NetworkHelper()
        networkHelper.requestPopUp(params: params, handler: { data in
            let banner = SSPPopUpAd(_addresponse: data, _popUpDelegate: self.popUpDelegate, _identifier: self.addId)
            handler(banner)
        })
    }
    
}


