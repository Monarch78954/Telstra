//
//  Parser.swift
//  telstraPOC
//
//  Created by Monarch Bhardwaj on 11/01/19.
//  Copyright © 2019 Monarch Bhardwaj. All rights reserved.
//

import UIKit

class Parser: NSObject {

    class func parsedData(_ data: Data) -> (NSDictionary?, Error?){
        guard let dataString = String(data: data, encoding: .isoLatin1) else{
            let error = Helping.makeError(ErrorCode.dataConversionError.rawValue, "Error in Data Parsing")
            return(nil, error)
        }
        if let data = dataString.data(using: .utf8){
            do{
                if let jasonDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary{
                    let title = jasonDictionary["title"] as? String ?? ""
                    var dataModel: [DataModel] = []
                    if let rows = jasonDictionary["rows"] as? [NSDictionary]{
                        for items in rows{
                            if let model = DataModel.makeDataModel(withDictionary: items){
                                dataModel.append(model)
                            }
                        }
                    }
                    let dataDic: NSDictionary = ["title": title, "model": dataModel]
                    return (dataDic, nil)
                }
            }
            catch{
                let error = Helping.makeError(ErrorCode.dataConversionError.rawValue, "Error inParsin Data")
                return(nil, error)
            }
        }
        return(nil,nil)
    }
}
