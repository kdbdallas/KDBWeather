//
//  WeatherNetworking.swift
//  KDBWeather
//
//  Created by Dallas Brown on 2/4/25.
//

import Foundation

enum WeatherNetworkError: Error {
    case failedToDecode
    case noData
    case badURL
    case badResponse
}

struct WeatherNetworking {
    
    // Get a free API key at: https://weatherstack.com or use the mock
    private let apiKey = ""
    private let APIURL = "https://api.weatherstack.com/current?access_key=APIKEY&query=CITY&units=f"
    
    func fetchCurrentWeatherDataMock(city: String) async throws -> CurrentWeatherData {
        guard let localURL = Bundle.main.url(forResource: "CurrentWeatherMock", withExtension: "json") else {
            throw WeatherNetworkError.badURL
        }
        
        do {
            let data = try Data(contentsOf: localURL)
            return try decodeResponseData(data: data)
        } catch {
            throw WeatherNetworkError.badURL
        }
    }
    
    func fetchCurrentWeatherData(city: String) async throws -> CurrentWeatherData {
        
        var fullAPIURL = APIURL.replacingOccurrences(of: "APIKEY", with: apiKey)
        fullAPIURL = fullAPIURL.replacingOccurrences(of: "CITY", with: city)
        fullAPIURL = fullAPIURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        guard !fullAPIURL.isEmpty else { throw WeatherNetworkError.badURL }
        
        guard let url = URL(string: fullAPIURL) else { throw WeatherNetworkError.badURL }
        
        let request = URLRequest(url: url)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw WeatherNetworkError.badResponse
            }
            
            guard !data.isEmpty else {
                throw WeatherNetworkError.noData
            }
            
            switch httpResponse.statusCode {
            case 200..<300:
                return try decodeResponseData(data: data)
            default:
                throw WeatherNetworkError.badResponse
            }
        } catch let error {
            throw error
        }
    }
    
    private func decodeResponseData(data: Data) throws -> CurrentWeatherData {
        do {
            let fetchedData = try JSONDecoder().decode(CurrentWeatherData.self, from: data)
            
            return fetchedData
        } catch {
            throw WeatherNetworkError.failedToDecode
        }
    }
}
