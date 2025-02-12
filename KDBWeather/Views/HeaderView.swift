//
//  HeaderView.swift
//  KDBWeather
//
//  Created by Dallas Brown on 2/2/25.
//

import SwiftUI

struct HeaderView: View {
    @Environment(WeatherViewModel.self) private var viewModel: WeatherViewModel
    
    var body: some View {
        
        Text(viewModel.currentWeather?.location?.name ?? "N/A")
            .font(.largeTitle)
            .padding(.top)
        
        Text(viewModel.localTime)
            .font(.subheadline)
            .padding(.bottom)
            .foregroundStyle(.gray)
        
        Spacer()
            .frame(height: 100)
        
        HStack {
            let icon = viewModel.iconForConditionCode(viewModel.currentWeather?.current?.weather_code ?? 113)
            
            Image(systemName: icon)
                .font(.title)
                .padding(.leading)
                .symbolEffect(.pulse)
            
            Text(viewModel.currentWeather?.current?.weather_descriptions.first ?? "N/A")
                .font(.title)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .padding(.leading)
        }
    }
}

#Preview {
    HeaderView()
        .environment(WeatherViewModel())
}
