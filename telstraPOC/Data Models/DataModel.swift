//
//  DataModel.swift
//  telstraPOC
//
//  Created by Monarch Bhardwaj on 11/01/19.
//  Copyright © 2019 Monarch Bhardwaj. All rights reserved.
//

import Foundation

class DataModel: Codable {
    let title: String?
    var rows: [Row]
}
struct Row: Codable{
    let title: String?
    let description: String?
    let imageHref: String?
}
