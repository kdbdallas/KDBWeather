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
    var currentWeather: CurrentWeatherData?
    var city: String = "Peoria, Arizona"
    var localTime: String = "N/A"
    var showLoadingError: Bool = false
    
    init(repository: WeatherRepository = WeatherRepository()) {
        self.repository = repository
    }
    
    func getCurrentWeather() async {
        do {
            currentWeather = try await repository.getCurrentWeatherDataMock(city: city)

            updateLocalTime()
        } catch let error {
            showLoadingError = true
            print("loading error \(error.localizedDescription)")
        }
    }
    
    private func updateLocalTime() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        dateFormatter.locale = Locale(identifier: "en_US")

        guard let time = currentWeather?.location.localtime, let date = dateFormatter.date(from: time) else {
            localTime = "N/A"
            return
        }

        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        
        localTime = dateFormatter.string(from: date)
    }
    
    func iconForConditionCode(_ code: Int) -> String {
        switch code {
        case 113:
            return "sun.max"
        case 116:
            return "cloud.sun"
        case 119, 122:
            return "cloud"
        case 143:
            return "sun.dust"
        case 176, 263, 266, 281, 284, 385:
            return "cloud.drizzle"
        case 179, 323, 326, 329, 332, 335, 338, 368, 371, 392, 395:
            return "cloud.snow"
        case 182, 185, 317, 320, 362, 365:
            return "cloud.sleet"
        case 200:
            return "cloud.sun.bolt"
        case 227, 230:
            return "wind.snow"
        case 248, 260:
            return "cloud.fog"
        case 293, 296, 299, 302, 311, 353:
            return "cloud.rain"
        case 305, 308, 314, 356, 359, 389:
            return "cloud.heavyrain"
        case 350, 374, 377:
            return "cloud.hail"
        case 386:
            return ""
        default:
            return ""
        }
    }
}
