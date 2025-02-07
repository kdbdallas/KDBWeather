//
//  ForecastWeatherDataModel.swift
//  KDBWeather
//
//  Created by Dallas Brown on 2/7/25.
//

struct ForecastWeatherData: Codable {
    let forecast: [WeatherDataForecast]

    struct WeatherDataForecast: Codable {
        let date: String
        let date_epoch: Int
        let astro: WeatherDataForecastAstro
        let mintemp: Int
        let maxtemp: Int
        let avgtemp: Int
        let totalsnow: Int
        let sunhour: Double
        let uv_index: Int
        let weather_code: Int
    }
    
    struct WeatherDataForecastAstro: Codable {
        let sunrise: String
        let sunset: String
        let moonrise: String
        let moonset: String
        let moon_phase: String
        let moon_illumination: Int
    }
}
