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
        debugPrint("PopUp request params: \(params)")
        let networkHelper = NetworkHelper()
        networkHelper.timeOutInterval = max((config.addTimeOutInterval ?? 30), 30)
        networkHelper.requestPopUp(params: params, handler: { data in
            let popUp = SSPPopUpAd(_addresponse: data, _popUpDelegate: self.popUpDelegate, _config: self.config, _identifier: self.addId)
            handler(popUp)
        })
    }
    
}


