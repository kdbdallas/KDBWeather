//
//  KDBWeatherApp.swift
//  KDBWeather
//
//  Created by Dallas Brown on 1/23/25.
//

import SwiftUI

@main
struct KDBWeatherApp: App {
    @State private var viewModel: WeatherViewModel = WeatherViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(viewModel)
        }
    }
}
