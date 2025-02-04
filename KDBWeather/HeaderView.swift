//
//  HeaderView.swift
//  KDBWeather
//
//  Created by Dallas Brown on 2/2/25.
//

import SwiftUI

struct HeaderView: View {
    
    @State private var animate = true
    
    var body: some View {
        Text("Peoria")
            .font(.largeTitle)
            .padding(.top)
        
        Text("Sunday, February 2")
            .font(.subheadline)
            .padding(.bottom)
            .foregroundStyle(.gray)
        
        Spacer()
            .frame(height: 100)
        
        HStack {
            Image(systemName: "sun.max")
                .font(.title)
                .padding(.leading)
                .symbolEffect(.rotate, options: .speed(0.5), isActive: true)
            
            Text("Sunny")
                .font(.title)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .padding(.leading)
        }
    }
}

#Preview {
    HeaderView()
}
