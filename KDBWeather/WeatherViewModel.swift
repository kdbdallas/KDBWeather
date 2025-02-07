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
    var forecastWeather: ForecastWeatherData?
    var city = "Peoria, Arizona"
    var localTime = "N/A"
    var showLoadingError = false
    let useMock = true
    
    init(repository: WeatherRepository = WeatherRepository()) {
        self.repository = repository
    }
    
    func getWeather() async {
        await withTaskGroup(of: Void.self) { [weak self] group in
            group.addTask {
                await self?.getCurrentWeather()
            }
            
            group.addTask {
                await self?.getForecastWeather()
            }
        }
    }
    
    private func getCurrentWeather() async {
        do {
            if useMock {
                currentWeather = try await repository.getCurrentWeatherDataMock(city: city)
            } else {
                currentWeather = try await repository.getCurrentWeatherData(city: city)
            }

            updateLocalTime()
        } catch let error {
            showLoadingError = true
            print("current weather loading error \(error.localizedDescription)")
        }
    }

    private func getForecastWeather() async {
        do {
            forecastWeather = try await repository.getForecastWeatherDataMock(city: city)
        } catch {
            showLoadingError = true
            print("forecast loading error \(error.localizedDescription)")
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
        
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let formattedDate = formatter.date(from: date) else { return "N/A" }
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: formattedDate)
        
        switch weekDay {
        case 1:
            return "Sunday"
        case 2:
            return "Monday"
        case 3:
            return "Tuesday"
        case 4:
            return "Wednesday"
        case 5:
            return "Thursday"
        case 6:
            return "Friday"
        case 7:
            return "Saturday"
        default:
            return "N/A"
        }
    }
}
