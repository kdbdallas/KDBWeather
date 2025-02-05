//
//  WeatherNetworking.swift
//  KDBWeather
//
//  Created by Dallas Brown on 2/4/25.
//

import Foundation

enum WeatherError: Error {
    case failedToDecode
    case noData
    case badURL
    case badResponse
}

struct WeatherNetworking {
    
    // Get a free API key at: https://weatherstack.com
    private let apiKey = "<SET ME>"
    private let APIURL = "https://api.weatherstack.com/current?access_key=APIKEY&query=CITY&units=f"
    
    func fetchWeatherData(city: String) async throws -> WeatherData {
        
        var fullAPIURL = APIURL.replacingOccurrences(of: "APIKEY", with: apiKey)
        fullAPIURL = fullAPIURL.replacingOccurrences(of: "CITY", with: city)
        fullAPIURL = fullAPIURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        guard !fullAPIURL.isEmpty else { throw WeatherError.badURL }
        
        guard let url = URL(string: fullAPIURL) else { throw WeatherError.badURL }
        
        let request = URLRequest(url: url)
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            
            do {
                return try decodeResponseData(data: data)
            } catch let error {
                throw error
            }
        } catch {
            throw WeatherError.badResponse
        }
    }
    
    private func decodeResponseData(data: Data) throws -> WeatherData {
        do {
            let fetchedData = try JSONDecoder().decode(WeatherData.self, from: data)
            
            return fetchedData
        } catch {
            throw WeatherError.failedToDecode
        }
    }
}
