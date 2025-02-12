//
//  WeatherRepository.swift
//  KDBWeather
//
//  Created by Dallas Brown on 2/4/25.
//

struct WeatherRepository {
    
    // MARK: - Current Weather
    func getCurrentWeatherData(city: String) async throws -> CurrentWeatherData {
        return try await WeatherNetworking().fetchCurrentWeatherData(city: city)
    }
    
    func getCurrentWeatherDataMock(city: String) async throws -> CurrentWeatherData {
        return try await WeatherNetworking().fetchCurrentWeatherDataMock(city: city)
    }
    
    // MARK: - Forecast Weather
    func getForecastWeatherDataMock(city: String) async throws -> ForecastWeatherData {
        return try await WeatherNetworking().fetchForecastWeatherDataMock(city: city)
    }
}
