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
        performRequest(urlString: urlString)
    }
    
    // Handle the networking part with OpenWeatherMap server
    func performRequest(urlString: String) {
        // 1. Create a URL
        if let url = URL(string: urlString) {
            // 2. Create a URL session (it's like the browser, the "thing" able to perform networking
            let session = URLSession(configuration: .default)
            // 3. Give the session a task
            let task = session.dataTask(with: url, completionHandler: handle(data:response:error:))
            // 4. Start the task
            task.resume()
        }

    }
    
    // handle the callback
    func handle(data: Data?, response: URLResponse?, error: Error?) -> Void {
        if error != nil {
            print(error!)
            return
        }
        
        // no errors: read the data
        if let safeData = data {
            parseJSON(weatherData: safeData)
        }
    }
    
    // parse the server response
    func parseJSON(weatherData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            print(decodedData.main.temp)
        } catch {
            print(error)
        }

    }
    
}
