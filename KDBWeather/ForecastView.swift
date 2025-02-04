//
//  ForecastView.swift
//  KDBWeather
//
//  Created by Dallas Brown on 2/2/25.
//

import SwiftUI

struct ForecastView: View {
    
    var body: some View {
        VStack {
            Text("5 Day Forecast")
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .foregroundStyle(.gray)
                .fontWeight(.semibold)
            
            Divider()
                .overlay(.gray)
                .padding(.trailing)
            
            HStack() {
                Text("Monday")
                    .font(.headline)
                
                Spacer()
                
                Image(systemName: "cloud.drizzle")
                    .font(.title2)
                    .padding(.leading)
                
                Spacer()
                
                Text("74°")
                    .font(.headline)
                
                Text("64°")
                    .font(.headline)
                    .foregroundStyle(.secondary)
                    .padding(.trailing)
            }
            .padding(.bottom)
            
            HStack() {
                Text("Tuesday")
                    .font(.headline)
                
                Spacer()
                
                Image(systemName: "cloud")
                    .font(.title2)
                    .padding(.leading)
                
                Spacer()
                
                Text("73°")
                    .font(.headline)
                
                Text("67°")
                    .font(.headline)
                    .foregroundStyle(.secondary)
                    .padding(.trailing)
            }
            .padding(.bottom)
        }
        .padding(.leading)
    }
}

#Preview {
    ForecastView()
}
