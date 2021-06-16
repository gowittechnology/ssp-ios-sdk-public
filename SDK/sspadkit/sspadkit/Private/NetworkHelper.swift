//
//  NetworkHelper.swift
//  sspadkit
//
//  Created by Dogus Yigit Ozcelik on 16.06.2021.
//

import Foundation

public struct AddResponse {
    let succes : SSPResult
    let errorMessage : String?
    let ad: String?
    let width : Int?
    let height : Int?
    let billable : String?
    
    init(with dictionary: [String:AnyObject]?, _succes: SSPResult, _errorMessage: String?) {
        
        self.errorMessage = _errorMessage
        if(_succes != .succes) {
            self.succes = _succes
            debugPrint("Error desc: \(_errorMessage ?? "")")
            self.ad = nil
            self.billable = nil
            self.height = nil
            self.width = nil
            return
        }
        guard let dictionary = dictionary else {
            self.succes = .networkResponseIsEmpty
            debugPrint("Error desc: \(_errorMessage ?? "")")
            self.ad = nil
            self.billable = nil
            self.height = nil
            self.width = nil
            return
        }
        
        self.ad = dictionary["ad"] as? String
        self.billable = dictionary["billable"] as? String
        self.height = dictionary["height"] as? Int
        self.width = dictionary["width"] as? Int
        
        guard let _ = self.ad else {
            self.succes = .didntReceiveAnyAdds
            debugPrint("Error desc: \(_errorMessage ?? "")")
            return
        }
        self.succes = .succes
    }
}

public class NetworkHelper {
    
    public var timeOutInterval : Int = 30
    
    private let bannerURL = "https://0d61aee2-60b9-49d3-b56f-56408f40c40d.mock.pstmn.io/ads?response=banner"
    private let popUpURL = "https://0d61aee2-60b9-49d3-b56f-56408f40c40d.mock.pstmn.io/ads?response=banner"
    
    func requestBanner(params: [String:Any], handler: @escaping ((AddResponse) -> Void)) {
        
        NetworkService().makeAPICall(url: bannerURL, params: params, success: { (data, response, error) in
            if let responseJSON = try? JSONSerialization.jsonObject(with: data!) as? [String:AnyObject]{
                
                debugPrint(responseJSON)
                
                let resp = AddResponse(with: responseJSON, _succes: .succes, _errorMessage: nil)
                handler(resp)
            } else {
                let resp = AddResponse(with: nil, _succes: .networkErrorJson, _errorMessage: error?.localizedDescription)
                handler(resp)
            }
            
        }, failure: { data, response, error in
            debugPrint("Network Error")
            if let err = error { debugPrint("Error Details: \(err)") }
            let resp = AddResponse(with: nil, _succes: .networkRequestFailed, _errorMessage: error?.localizedDescription)
            handler(resp)
        })

    }
    
    func requestPopUp(params: [String:Any], handler: @escaping ((AddResponse) -> Void)) {
        
        NetworkService().makeAPICall(url: popUpURL, params: params, success: { (data, response, error) in
            if let responseJSON = try? JSONSerialization.jsonObject(with: data!) as? [String:AnyObject]{
                debugPrint(responseJSON)
                let resp = AddResponse(with: responseJSON, _succes: .succes, _errorMessage: nil)
                handler(resp)
            } else {
                let resp = AddResponse(with: nil, _succes: .networkErrorJson, _errorMessage: error?.localizedDescription)
                handler(resp)
            }
            
        }, failure: { data, response, error in
            debugPrint("Network Error")
            if let err = error { debugPrint("Error Details: \(err)") }
            let resp = AddResponse(with: nil, _succes: .networkRequestFailed, _errorMessage: error?.localizedDescription)
            handler(resp)
        })

    }
}
