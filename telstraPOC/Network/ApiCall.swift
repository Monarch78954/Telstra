//
//  ApiCall.swift
//  telstraPOC
//
//  Created by Monarch Bhardwaj on 11/01/19.
//  Copyright © 2019 Monarch Bhardwaj. All rights reserved.
//

import UIKit
import Foundation

protocol ApiCallDelegate: class {
    func didRecieveResponse(_ data: NSDictionary?, _ code: Int?, _ error: Error?)
}

class ApiCall: NSObject {
    weak var delegate: ApiCallDelegate?
    func requestData(_ url: String){
        NetworkManager.defaultManager.fetchDataFrom(url) { (data, response, error) in
            let code = response?.statusCode
            self.delegate?.didRecieveResponse(data as? NSDictionary, code, error)
        }
    }
}
