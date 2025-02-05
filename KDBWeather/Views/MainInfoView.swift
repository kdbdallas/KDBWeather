//
//  MainInfoView.swift
//  KDBWeather
//
//  Created by Dallas Brown on 2/2/25.
//

import SwiftUI

struct MainInfoView: View {
    
    var body: some View {
        HStack(alignment: .center) {
            
            Text("118°")
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
                Text("81°")
                    .font(.footnote)
                    .frame(height: 15)
                
                Text("3 mph")
                    .font(.footnote)
                    .frame(height: 15)
                
                Text("17%")
                    .font(.footnote)
                    .frame(height: 15)
                
                Text("0%")
                    .font(.footnote)
                    .frame(height: 15)
            }
            .padding(.trailing)
        }
    }
}

#Preview {
    MainInfoView()
}
