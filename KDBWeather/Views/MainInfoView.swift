//
//  MainInfoView.swift
//  KDBWeather
//
//  Created by Dallas Brown on 2/2/25.
//

import SwiftUI

struct MainInfoView: View {
    @Environment(WeatherViewModel.self) private var viewModel: WeatherViewModel
    
    var body: some View {
        HStack(alignment: .center) {
            
            let currentWeather = viewModel.currentWeather?.current
            
            let temperature = String(currentWeather?.temperature ?? 999)
            let feelsLike = String(currentWeather?.feelslike ?? 999)
            let windSpeed = String(currentWeather?.wind_speed ?? 999)
            let humidity = String(currentWeather?.humidity ?? 999)
            let precipitation = String(currentWeather?.precip ?? 999)
            
            Text("\(temperature)°")
                .font(.system(size: 105, weight: .thin))
                .scaledToFit()
                .minimumScaleFactor(0.5)
                .lineLimit(1)
                .padding(.leading)
            
            Spacer()
            
            VStack(alignment: .leading) {
                Text("Feels Like")
                    .textCase(.uppercase)
                    .font(.footnote)
                    .frame(height: 15)
                
                Text("Wind Speed")
                    .textCase(.uppercase)
                    .font(.footnote)
                    .frame(height: 15)
                
                Text("Humidity")
                    .textCase(.uppercase)
                    .font(.footnote)
                    .frame(height: 15)
                
                Text("Precipitation")
                    .textCase(.uppercase)
                    .font(.footnote)
                    .frame(height: 15)
            }
            
            Spacer()
                .frame(width: 80)
            
            VStack(alignment: .trailing) {
                Text("\(feelsLike)°")
                    .font(.footnote)
                    .frame(height: 15)
                
                Text("\(windSpeed) mph")
                    .font(.footnote)
                    .frame(height: 15)
                
                Text("\(humidity)%")
                    .font(.footnote)
                    .frame(height: 15)
                
                Text("\(precipitation)%")
                    .font(.footnote)
                    .frame(height: 15)
            }
            .padding(.trailing)
        }
    }
}

#Preview {
    MainInfoView()
        .environment(WeatherViewModel())
}
