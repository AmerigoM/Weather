//
//  WeatherData.swift
//  Weather
//
//  Created by Amerigo Mancino on 20/10/2019.
//  Copyright © 2019 Amerigo Mancino. All rights reserved.
//

import Foundation

/*
 * We have to replicate the structure of the JSON coming back from the network call
 * containing the properties that we are interesed in capture; those properies' names
 * must be equal to the names that you can read in the JSON file that comes back
 */

struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let description: String
    let id: Int
}
