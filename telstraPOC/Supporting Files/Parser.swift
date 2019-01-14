//
//  Parser.swift
//  telstraPOC
//
//  Created by Monarch Bhardwaj on 11/01/19.
//  Copyright © 2019 Monarch Bhardwaj. All rights reserved.
//

import UIKit

class Parser: NSObject {

    class func parsedData(_ data: Data) -> (DataModel?, Error?){
        guard let dataString = String(data: data, encoding: .isoLatin1) else{
            let error = Helping.makeError(ErrorCode.dataConversionError.rawValue, "Error in Data Parsing")
            return(nil, error)
        }
        if let data = dataString.data(using: .utf8){
            do{
                let obj = try JSONDecoder().decode(DataModel.self, from: data)
                obj.rows = obj.rows.filter({ (row) -> Bool in
                    if row.description == nil && row.title == nil && row.imageHref == nil {
                        return false
                    }
                    return true
                })
                return(obj, nil)
            }catch{
                let error = Helping.makeError(ErrorCode.dataConversionError.rawValue, "Error inParsin Data")
                return(nil, error)
            }


        }
        return(nil,nil)
    }
}
