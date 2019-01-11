//
//  DataModel.swift
//  telstraPOC
//
//  Created by Monarch Bhardwaj on 11/01/19.
//  Copyright © 2019 Monarch Bhardwaj. All rights reserved.
//

import UIKit
import Foundation

class DataModel: NSObject {
    
    let rowTitle: String?
    let rowDescription: String?
    let rowImageURL: URL?
    
    private init(rowTitle title:String?, rowDescription description: String?, rowImageURL imageURL: URL?) {
        rowTitle = title
        rowDescription = description
        rowImageURL = imageURL
    }
    
    class func makeDataModel(withDictionary dictionary:NSDictionary) -> DataModel?{
        let title = dictionary["title"] as? String ?? ""
        let desc = dictionary["description"] as? String ?? ""
        let imageURLString = dictionary["imageHref"] as? String ?? ""
        if title != "" || desc != "" || imageURLString != ""{
            var imageURL:URL? = nil
            if imageURLString != ""{
                imageURL = URL(string: imageURLString)
            }
            return DataModel(rowTitle: title, rowDescription: desc, rowImageURL: imageURL)
        }
        return nil
    }
}
