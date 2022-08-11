//
//  CountryModel.swift
//  Galaktion Nizharadze, Assignment #21
//
//  Created by Gaga Nizharadze on 11.08.22.
//

import Foundation

struct Country: Decodable {
    let name: String
    let capital: String?
    let flagURL: String
    let regionalBlocs: [RegionalBloc]?
    
    enum CodingKeys: String, CodingKey {
        case flagURL = "flag"
        case name, capital, regionalBlocs
    }
}


struct RegionalBloc: Decodable {
    let acronym: String
    let name: String
}
