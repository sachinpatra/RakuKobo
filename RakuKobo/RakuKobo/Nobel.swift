//
//  Nobel.swift
//  RakuKobo
//
//  Created by Sachin Kumar Patra on 12/11/20.
//

import SwiftUI

struct Nobel: Decodable, Identifiable {
    var id: Int
    var category: String
    var died: String
    var diedcity: String
    var borncity: String
    var born: String
    var surname: String
    var firstname: String
    var motivation: String   
    var location: NobLocation
    var city: String
    var borncountry: String
    var year: String
    var diedcountry: String
    var country: String
    var gender: String
    var name: String
        
    enum CodingKeys: String, CodingKey {
        case id
        case category
        case died
        case diedcity
        case borncity
        case born
        case surname
        case firstname
        case motivation
        case location
        case city
        case borncountry
        case year
        case diedcountry
        case country
        case gender
        case name
    }

}

struct NobLocation: Decodable {
    var lat: Double
    var lng: Double
}
