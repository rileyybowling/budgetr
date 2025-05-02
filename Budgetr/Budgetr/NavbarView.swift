//
//  NavbarView.swift
//  Budgetr
//
//  Created by Tanner Grunt on 4/30/25.
//


//
//  NavbarView.swift
//  
//
//  Created by Tanner Grunt on 4/25/25.
//

import SwiftUI

struct NavbarView: View {
    var body: some View {
        NavigationStack {
            HStack {
                NavigationLink(destination: AddExpenseView()) {
                    VStack {
                        Image(systemName: "plus.square")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .foregroundColor(Color.black)
                        Text("Add Expense")
                            .font(.caption)
                            .foregroundColor(Color.black)
                    }
                    .frame(maxWidth: .infinity) // ✅ each button same width
                }

                NavigationLink(destination: ContentView()) {
                    VStack {
                        Image(systemName: "house.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .foregroundColor(Color.black)
                        Text("Home")
                            .font(.caption)
                            .foregroundColor(Color.black)
                    }
                    .frame(maxWidth: .infinity) // ✅
                }

                NavigationLink(destination: BudgetView()) {
                    VStack {
                        Image(systemName: "wallet.bifold")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .foregroundColor(Color.black)
                        Text("Budget")
                            .font(.caption)
                            .foregroundColor(Color.black)
                    }
                    .frame(maxWidth: .infinity) // ✅
                }
            }
            .padding(.horizontal)
            .padding(.top, 8)
            .padding(.bottom, 12)
            .frame(height: 90)
            .background(Color(hex: 0xcccccc))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(radius: 5)
        }
    }
}

#Preview {
    NavbarView()
}
