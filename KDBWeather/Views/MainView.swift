//
//  MainView.swift
//  KDBWeather
//
//  Created by Dallas Brown on 2/2/25.
//

import SwiftUI

struct MainView: View {
    @Environment(WeatherViewModel.self) private var viewModel: WeatherViewModel
    
    let gradientStartColor = Color(red: 0.08, green: 0.11, blue: 0.29)
    let gradientEndColor = Color(red: 0.34, green: 0.24, blue: 0.46)
    
    var body: some View {
        @Bindable var viewModel = viewModel
        
        TabView {
            ForEach(1...5, id: \.self) { _ in
                ScrollView(.vertical) {
                    VStack {
                        HeaderView()
                        
                        Spacer()
                        
                        MainInfoView()
                        
                        Spacer()
                            .frame(height: 150)
                        
                        ForecastView()
                    }
                }
            }
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .automatic))
        .foregroundStyle(.white)
        .background(LinearGradient(colors: [gradientStartColor, gradientEndColor], startPoint: .top, endPoint: .bottom))
        .onAppear {
            UIRefreshControl.appearance().tintColor = .white
            
            Task {
                await viewModel.getWeather()
            }
        }
        .refreshable {
            Task {
                await viewModel.getWeather()
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
