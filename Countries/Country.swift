//
//  File.swift
//  Countries
//
//  Created by Bilal on 27.03.2022.
//

import Foundation

class Country: NSObject, NSCoding{
    
    var name: String!
    var code: String!
    
    override init(){
        
    }
    
    init(name: String, code: String){
        self.name = name
        self.code = code
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(self.name, forKey: "name")
        coder.encode(self.code, forKey: "code")
    }
    
    required convenience init?(coder: NSCoder) {
        let name = coder.decodeObject(forKey: "name") as! String
        let code = coder.decodeObject(forKey: "code") as! String
        
        self.init(name: name, code: code)
    }
}
