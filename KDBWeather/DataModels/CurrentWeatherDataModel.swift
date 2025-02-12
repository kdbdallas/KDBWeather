//
//  CurrentWeatherDataModel.swift
//  KDBWeather
//
//  Created by Dallas Brown on 2/7/25.
//


struct CurrentWeatherData: Codable {
    let request: WeatherDataRequest?
    let location: WeatherDataLocation?
    let current: WeatherDataCurrent?
    
    let success: Bool?
    let error: WeatherDataError?
    
    struct WeatherDataRequest: Codable {
        let type: String
        let query: String
        let language: String
        let unit: String
    }
    
    struct WeatherDataLocation: Codable {
        let name: String
        let country: String
        let region: String
        let lat: String
        let lon: String
        let timezone_id: String
        let localtime: String
        let localtime_epoch: Int
        let utc_offset: String
    }
    
    struct WeatherDataCurrent: Codable {
        let observation_time: String
        let temperature: Int
        let weather_code: Int
        let weather_descriptions: [String]
        let wind_speed: Int
        let wind_degree: Int
        let wind_dir: String
        let pressure: Int
        let precip: Int
        let humidity: Int
        let cloudcover: Int
        let feelslike: Int
        let uv_index: Int
        let visibility: Int
        let is_day: String
    }
    
    struct WeatherDataError: Codable {
        let code: Int
        let info: String
    }
}
