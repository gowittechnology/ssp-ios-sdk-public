//
//  NetworkService.swift
//  sspadkit
//
//  Created by Dogus Yigit Ozcelik on 16.06.2021.
//

import Foundation

public class NetworkService {

    func makeAPICall(url: String,params: Dictionary<String, Any>?, timeOutInterVal: Int = 30, success:@escaping ( Data? ,HTTPURLResponse?  , NSError? ) -> Void, failure: @escaping ( Data? ,HTTPURLResponse?  , NSError? )-> Void) {

        var request = URLRequest(url: URL(string: url)!)


        if let params = params {


            let  jsonData = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)

            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
        }
        request.httpMethod = "POST"


        let configuration = URLSessionConfiguration.default

        configuration.timeoutIntervalForRequest = TimeInterval(timeOutInterVal)
        configuration.timeoutIntervalForResource = TimeInterval(timeOutInterVal)

        let session = URLSession(configuration: configuration)
        debugPrint("add request started.")
        
        session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in

            debugPrint("response received.")
            if let data = data {
                
                if let resp = response as? HTTPURLResponse {
                    debugPrint("response: \(resp).")
                }
                
                if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                    
                    success(data , response , error as NSError?)
                } else {
                    failure(data , response as? HTTPURLResponse, error as NSError?)
                }
            }else {

                debugPrint("response data is empty.")
                failure(data , response as? HTTPURLResponse, error as NSError?)

            }
            }.resume()

    }
    
}
