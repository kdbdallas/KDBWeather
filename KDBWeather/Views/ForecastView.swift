//
//  ForecastView.swift
//  KDBWeather
//
//  Created by Dallas Brown on 2/2/25.
//

import SwiftUI

struct ForecastView: View {
    @Environment(WeatherViewModel.self) private var viewModel: WeatherViewModel
    
    var body: some View {
        let forecastWeather = viewModel.forecastWeather
        let numDays = forecastWeather?.forecast.count ?? 0
        
        VStack {
            Text("\(String(numDays)) Day Forecast")
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .foregroundStyle(.gray)
                .fontWeight(.semibold)
            
            Divider()
                .overlay(.gray)
                .padding(.trailing)
            
            ForEach(0..<numDays, id: \.self) { index in
                let dayForecast = forecastWeather?.forecast[index]
                let weatherCode = dayForecast?.weather_code ?? 113
                let date = dayForecast?.date ?? ""
                let dayOfWeek = viewModel.getDayOfWeek(date: date)
                let icon = viewModel.iconForConditionCode(weatherCode)
                let maxTemp = String(dayForecast?.maxtemp ?? 999)
                let minTemp = String(dayForecast?.mintemp ?? 999)
                
                HStack() {
                    Text(dayOfWeek)
                        .font(.headline)
                    
                    Spacer()
                    
                    Image(systemName: icon)
                        .font(.title2)
                        .padding(.leading)
                    
                    Spacer()
                    
                    Text("\(maxTemp)°")
                        .font(.headline)
                    
                    Text("\(minTemp)°")
                        .font(.headline)
                        .foregroundStyle(.secondary)
                        .padding(.trailing)
                }
                .padding(.bottom)
            }
        }
        .padding(.leading)
    }
}

#Preview {
    ForecastView()
        .environment(WeatherViewModel())
}
