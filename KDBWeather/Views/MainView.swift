//
//  MainView.swift
//  KDBWeather
//
//  Created by Dallas Brown on 2/2/25.
//

import SwiftUI

struct MainView: View {
    @Environment(WeatherViewModel.self) private var viewModel: WeatherViewModel
    
    let gradientStartColor = Color(cgColor: UIColor(red: 0.08, green: 0.11, blue: 0.29, alpha: 1.0).cgColor)
    let gradientEndColor = Color(cgColor: UIColor(red: 0.34, green: 0.24, blue: 0.46, alpha: 1.0).cgColor)
    
    var body: some View {
        @Bindable var viewModel = viewModel
        
        ScrollView(.vertical) {
            VStack {
                HeaderView()
                    .environment(viewModel)
                
                Spacer()
                
                MainInfoView()
                
                Spacer()
                    .frame(height: 150)
                
                ForecastView()
            }
        }
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity)
        .background(LinearGradient(colors: [gradientStartColor, gradientEndColor], startPoint: .top, endPoint: .bottom))
        .onAppear {
            UIRefreshControl.appearance().tintColor = .white
            
            Task {
                await viewModel.getCurrentWeather()
            }
        }
        .refreshable {
            Task {
                await viewModel.getCurrentWeather()
            }
        }
        .alert("Error Refreshing Data", isPresented: $viewModel.showLoadingError) {
            Button("Ok", role: .cancel) { }
        }
    }
}

#Preview {
    MainView()
        .environment(WeatherViewModel())
}
