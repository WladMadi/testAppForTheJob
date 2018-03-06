//
//  DataManager.swift
//  testAppForJob
//
//  Created by mac on 05.03.2018.
//  Copyright © 2018 madINC. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class DataManager {
    
    func getData() {

        let getDataURL: String = "http://phisix-api3.appspot.com/stocks.json"


        Alamofire.request(getDataURL).validate().responseJSON { response in
            switch response.result {
            case .success(let value):

                
                let json = JSON(value)
                print("DATA_LOADED")
                namesArray = json["stock"].arrayValue.map({$0["name"].stringValue})
                amountsArray = json["stock"].arrayValue.map({$0["amount"].doubleValue})
                volumesArray = json["stock"].arrayValue.map({$0["volume"].doubleValue})
                
//                print(namesArray)
//                print(amountsArray)
//                print(volumesArray)
                
                
            case .failure(_):
                print ("LoadData Error")
            }
        }
    }
    
    
    
}
