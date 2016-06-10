//
//  people.swift
//  ExamApp
//
//  Created by Baptiste CAVALIÉ on 10/06/2016.
//  Copyright © 2016 Web School Factory. All rights reserved.
//

import Foundation
import Alamofire

struct People {
    
    //name, height, mass, skin color
    let name: String
    let height: Int
    let mass: Int
    let skin_color: String
    
    //Constructeur prenant en entrée un Dictionary
    init(dict: Dictionary<String, AnyObject>) {
        
        //Les infos de base
        name = dict["name"] as! String
        height = dict["height"] as! Int
        mass = dict["mass"] as! Int
        skin_color = dict["skin_color"] as! String
    }
}
    
    //MARK: Remote functions
    extension People {
        static func getRemotePeoples(offset: Int, completionHandler: Response<AnyObject, NSError> -> Void) {
            let apiKey = ""
            let ts = ""
            let hash = ""
            
            let param: [String : AnyObject] = ["apikey" : apiKey, "hash" : hash, "ts" : ts, "offset" : offset]
            
            Alamofire.request(.GET, "http://swapi.co/api/people/?format=api", parameters: param).responseJSON { response in
                
                completionHandler(response)
            }
    }
}