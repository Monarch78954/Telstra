//
//  NetworkManager.swift
//  telstraPOC
//
//  Created by Monarch Bhardwaj on 11/01/19.
//  Copyright © 2019 Monarch Bhardwaj. All rights reserved.
//

import Foundation

typealias completionHandler = (Any?, HTTPURLResponse?, Error?) -> Void

final class NetworkManager: NSObject {

    static let defaultManager = NetworkManager()
    
    private override init() {
    }
    
    func fetchDataFrom(_ urlString: String, _ completionBlock: @escaping completionHandler){
        guard let url = URL(string: urlString) else{
            print("Error in creating URL")
            let error = Helping.makeError(ErrorCode.urlConversionFailure.rawValue, "Api Call Failed")
            completionBlock(nil,nil, error)
            return
        }
        let getData = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else{
                print("Network Call Error")
                completionBlock(nil, nil, error)
                return
            }
            let resp = response as? HTTPURLResponse
            if data != nil{
                let (parsedData, parsingError) = Parser.parsedData(data!)
                if parsedData != nil{
                    completionBlock(parsedData, resp, parsingError)
                }else{
                    completionBlock(nil, resp, parsingError)
                }
            }else{
                let noDataFound = Helping.makeError(ErrorCode.dataNotFound.rawValue, "No Data Found")
                completionBlock(nil, resp, noDataFound)
            }
        }
        getData.resume()
    }
}
