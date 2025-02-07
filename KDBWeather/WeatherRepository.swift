//
//  WeatherRepository.swift
//  KDBWeather
//
//  Created by Dallas Brown on 2/4/25.
//

struct WeatherRepository {
    
    // MARK: - Current Weather
    func getCurrentWeatherData(city: String) async throws -> CurrentWeatherData {
        do {
            return try await WeatherNetworking().fetchCurrentWeatherData(city: city)
        } catch {
            throw WeatherNetworkError.noData
        }
    }
    
    func getCurrentWeatherDataMock(city: String) async throws -> CurrentWeatherData {
        do {
            return try await WeatherNetworking().fetchCurrentWeatherDataMock(city: city)
        } catch {
            throw WeatherNetworkError.noData
        }
    }
    
    // MARK: - Forecast Weather
    func getForecastWeatherDataMock(city: String) async throws -> ForecastWeatherData {
        do {
            return try await WeatherNetworking().fetchForecastWeatherDataMock(city: city)
        } catch {
            throw WeatherNetworkError.noData
        }
    }
}
