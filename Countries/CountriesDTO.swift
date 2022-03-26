//
//  CountriesDTO.swift
//  AdessoCountries
//
//  Created by Bilal on 24.03.2022.
//

import Foundation

// MARK: - CountriesDTO
struct CountriesDTO: Codable {
    let data: [Datum]

}

// MARK: - Datum
struct Datum: Codable {
    let code: String
    
    let name: String

    enum CodingKeys: String, CodingKey {
        case code, name
        
    }
}
