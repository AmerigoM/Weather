//
//  WeatherManager.swift
//  Weather
//
//  Created by Amerigo Mancino on 20/10/2019.
//  Copyright © 2019 Amerigo Mancino. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(weather: WeatherModel)
}

struct WeatherManager {
    let weatherURL = "http://api.openweathermap.org/data/2.5/weather?appid=myAppId&units=metric"
    
    var delegate: WeatherManagerDelegate?

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
            if let weather = self.parseJSON(weatherData: safeData) {
                // return the data to the view controller via protocol method
                self.delegate?.didUpdateWeather(weather: weather)
            }
        }
    }
    
    // parse the server response
    func parseJSON(weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            // print(decodedData.main.temp)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            print(weather.conditionName)
            return weather
        } catch {
            print(error)
            return nil
        }

    }
    
}
