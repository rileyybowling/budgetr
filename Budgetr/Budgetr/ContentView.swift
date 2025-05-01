//
//  ContentView.swift
//  Budgetr
//
//  Created by Riley Bowling on 3/12/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            HStack {
                NavigationLink(destination: SettingsView()) {
                    Label("", systemImage: "gearshape.2.fill")
                }
                .padding(10)
                .foregroundStyle(Color.black)
                Spacer()
                Text("Budgetr")
                    .bold()
                Spacer()
                NavigationLink(destination: ContentView()) {
                    Label("", systemImage: "bell.fill")
                }
                .padding(10)
                .foregroundStyle(Color.black)
            }
            .frame(height: 75)
            .cornerRadius(25)
            .background(Color(hex: 0x9b8bf4).ignoresSafeArea())
            .clipShape(RoundedRectangle(cornerRadius: 12))
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        
        NavbarView()
    }
}

extension Color {
    init(hex: Int, opacity: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: opacity
        )
    }
}

#Preview {
    ContentView()
}
