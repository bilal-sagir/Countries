//
//  SCTransfer.swift
//  Countries
//
//  Created by Bilal on 27.03.2022.
//

import Foundation

class SCTransfer{
    static let instance = SCTransfer()
    
    var countries: [Country]?
    var country: Country?
    
    private init(){
        
    }
}
