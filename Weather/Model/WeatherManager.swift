//
//  WeatherManager.swift
//  Weather
//
//  Created by Amerigo Mancino on 20/10/2019.
//  Copyright © 2019 Amerigo Mancino. All rights reserved.
//

import Foundation

struct WeatherManager {
    let weatherURL = "http://api.openweathermap.org/data/2.5/weather?appid=myAppId&units=metric"

    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        
    }
    
}
