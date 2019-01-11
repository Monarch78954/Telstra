//
//  telstraPOCTests.swift
//  telstraPOCTests
//
//  Created by Monarch Bhardwaj on 10/01/19.
//  Copyright © 2019 Monarch Bhardwaj. All rights reserved.
//

import XCTest
@testable import telstraPOC

class telstraPOCTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    //if all passed values are nil then it will return nil
    func testMakeModelObjectToNil() {
        let disc: NSDictionary = ["title": NSNull(), "imageHref": NSNull(), "description": NSNull()]
        let dataModelObject = DataModel.makeDataModel(withDictionary: disc)
        XCTAssertNil(dataModelObject)
    }

    //sending plain text with utf8 encoding
    func testParsingOfData() {
        let data = ["title":"About Canada",
                    "rows":[
                        [
                            "title":"Beavers",
                            "description":"Beavers are second only to humans in their ability to manipulate and change their environment. They can measure up to 1.3 metres long. A group of beavers is called a colony",
                            "imageHref":"http://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/220px-American_Beaver.jpg"
                        ],
                        [
                            "title":"Transportation",
                         
                            "description":"It is a well known fact that polar bears are the main mode of transportation in Canada. They consume far less gas and have the added benefit of being difficult to steal.",
                            "imageHref":"http://1.bp.blogspot.com/_VZVOmYVm68Q/SMkzZzkGXKI/AAAAAAAAADQ/U89miaCkcyo/s400/the_golden_compass_still.jpg"
                        ],
                        [
                            "title":"Eh",
                            "description":"A chiefly Canadian interrogative utterance, usually expressing surprise or doubt or seeking confirmation.",
                            "imageHref":"http://fyimusic.ca/wp-content/uploads/2008/06/hockey-night-in-canada.thumbnail.jpg"
                        ],
                        [
                            "title":"Housing",
                            "description":"Warmer than you might think.",
                            "imageHref":"http://icons.iconarchive.com/icons/iconshock/alaska/256/Igloo-icon.png"
                        ]
                ]
        ] as [String: Any]
        do{
            let jasonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
            let response = Parser.parsedData(jasonData)
            XCTAssertNotNil(response.0)
            XCTAssertNil(response.1)
        }catch{
            print("Error in data conversion")
        }
    }
    
    //test api calls
    func testApiCalls(){
        NetworkManager.defaultManager.fetchDataFrom(URLString.dataURLString) { (data, response, error) in
            XCTAssertEqual(200, response?.statusCode, "Recived response code :: \(String(describing: response?.statusCode))")
        }
    }

}
