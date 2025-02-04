//
//  MainView.swift
//  KDBWeather
//
//  Created by Dallas Brown on 2/2/25.
//

import SwiftUI

struct MainView: View {
    let gradientStartColor = Color(cgColor: UIColor(red: 0.08, green: 0.11, blue: 0.29, alpha: 1.0).cgColor)
    let gradientEndColor = Color(cgColor: UIColor(red: 0.34, green: 0.24, blue: 0.46, alpha: 1.0).cgColor)
    
    var body: some View {
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
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity)
        .background(LinearGradient(colors: [gradientStartColor, gradientEndColor], startPoint: .top, endPoint: .bottom))
        .onAppear {
            UIRefreshControl.appearance().tintColor = .white
        }
        .refreshable {
            //
        }
    }
}

#Preview {
    MainView()
}
