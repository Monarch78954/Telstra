//
//  Helping.swift
//  telstraPOC
//
//  Created by Monarch Bhardwaj on 11/01/19.
//  Copyright © 2019 Monarch Bhardwaj. All rights reserved.
//

import UIKit

enum ErrorCode: Int {
    case dataConversionError = 8000
    case parsingError = 8001
    case urlConversionFailure = 8002
    case errorInNetworkCall = 8003
    case dataNotFound = 8004
}

class Helping: NSObject {
    class func makeError(_ code:Int, _ description:String) -> Error {
        return NSError(domain: "", code: code, userInfo: [NSLocalizedDescriptionKey: description]) as Error
    }
}
