//
//  WeatherViewModel.swift
//  KDBWeather
//
//  Created by Dallas Brown on 2/4/25.
//

import Foundation
import Observation

@Observable class WeatherViewModel {
    var repository: WeatherRepository
    var currentWeather: WeatherData?
    var city: String = "Peoria, Arizona"
    var showLoadingError: Bool = false
    
    init(repository: WeatherRepository = WeatherRepository()) {
        self.repository = repository
    }
    
    func getCurrentWeather() async {
        do {
            currentWeather = try await repository.getWeatherData(city: city)
            print("got current weather")
        } catch let error {
            showLoadingError = true
            print("loading error \(error.localizedDescription)")
        }
    }
}
