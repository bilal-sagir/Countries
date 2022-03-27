//
//  CountryDetailDTO.swift
//  Countries
//
//  Created by Bilal on 27.03.2022.
//

import Foundation

// MARK: - Detail
struct CountryDetailDTO: Codable {
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    
    let flagImageURI: String
    let wikiDataID: String

    enum CodingKeys: String, CodingKey {
        
        case flagImageURI = "flagImageUri"
        
        case wikiDataID = "wikiDataId"
    }
}



