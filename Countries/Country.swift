//
//  File.swift
//  Countries
//
//  Created by Bilal on 27.03.2022.
//

import Foundation

class Country: NSObject {
    
    var name: String!
    var code: String!
    
    override init(){
        
    }
    
    init(name: String, code: String){
        self.name = name
        self.code = code
    }
}
