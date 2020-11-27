//
//  Person.swift
//  JSONExemplar
//
//  Created by Salvarajah, Prajina on 2020-11-27.
//

import Foundation

// by adhereing to the codable protocol,
//this means that an instance of Person can
// be converted to a JSON file.
//By adhering to the Identifable protocol,
// each person can be uniquely identified
// This is a requirement to show the people in a list

struct Person: Codable, Identifiable {
    var name: String
    var id: Int
}

// Sheet1 in an array of Person

struct People: Codable {
    var sheet1: [Person]
}



