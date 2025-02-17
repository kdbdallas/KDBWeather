//
//  WeatherViewModel.swift
//  KDBWeather
//
//  Created by Dallas Brown on 2/4/25.
//

import Foundation
import Observation

@Observable class WeatherViewModel {
    @ObservationIgnored var repository: WeatherRepository
    @ObservationIgnored var city = "Peoria, Arizona"
    @ObservationIgnored let useMock = true

    @MainActor var currentWeather: CurrentWeatherData?
    @MainActor var forecastWeather: ForecastWeatherData?
    @MainActor var localTime = "N/A"
    @MainActor var showLoadingError = false
    
    init(repository: WeatherRepository = WeatherRepository()) {
        self.repository = repository
    }
    
    @MainActor
    func getWeather() async {
        await getCurrentWeather()
        await getForecastWeather()
    }
    
    @MainActor
    private func getCurrentWeather() async {
        Task {
            do {
                if useMock {
                    currentWeather = try await repository.getCurrentWeatherDataMock(city: city)
                } else {
                    currentWeather = try await repository.getCurrentWeatherData(city: city)
                }
                
                // Check if we got a valid response from the API or an Error
                guard currentWeather?.error == nil && currentWeather?.current != nil else {
                    print("current weather loading error: \(String(describing: currentWeather?.error?.info))")
                    showLoadingError = true
                    return
                }
                
                updateLocalTime()
                
            } catch {
                print("current weather loading error \(error)")
                showLoadingError = true
            }
        }
    }

    @MainActor
    private func getForecastWeather() async {
        Task {
            do {
                forecastWeather = try await repository.getForecastWeatherDataMock(city: city)
            } catch {
                print("forecast loading error \(error)")
                showLoadingError = true
            }
        }
    }

    @MainActor
    private func updateLocalTime() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        dateFormatter.locale = Locale(identifier: "en_US")

        guard let time = currentWeather?.location?.localtime, let date = dateFormatter.date(from: time) else {
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
        case 176, 263, 266, 281, 284, 385, 386:
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
        default:
            return ""
        }
    }
    
    func getDayOfWeek(date: String) -> String {
        guard !date.isEmpty else { return "N/A" }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        guard let formattedDate = formatter.date(from: date) else { return "N/A" }

        return formatter.weekdaySymbols[Calendar.current.component(.weekday, from: formattedDate) - 1]
    }
}
