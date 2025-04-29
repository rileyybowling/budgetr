//
//  ContentView.swift
//  Budgetr
//
//  Created by Riley Bowling on 3/12/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query(sort: \Expense.date, order: .reverse) private var expenses: [Expense]

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
                
                NavigationLink(destination: NotificationsView()) {
                    Label("", systemImage: "bell.fill")
                }
                .padding(10)
                .foregroundStyle(Color.black)
            }
            .frame(height: 75)
            .background(Color(hex: 0x9B8BF4).ignoresSafeArea())
            .clipShape(RoundedRectangle(cornerRadius: 12))
            
            //Created placeholder for the chart
            Spacer()
            Circle()
                .fill(LinearGradient(colors: [.green, .blue], startPoint: .top, endPoint: .bottom))
                .frame(width: 200, height: 200)
            Spacer()

            ScrollView {
                VStack(spacing: 16) {
                    ForEach(expenses.prefix(5)) { expense in
                        TransactionRow(expense: expense)
                    }
                }
                .padding()
            }

            Spacer()
        }
        .padding()
    }
}

struct TransactionRow: View {
    var expense: Expense

    var body: some View {
        HStack {
            Image(systemName: iconName(for: expense.category))
                .font(.system(size: 24))
                .foregroundColor(.blue)
            
            VStack(alignment: .leading) {
                Text(expense.category)
                    .font(.subheadline)
                    .bold()
            }
            Spacer()
            HStack {
                Image(systemName: expense.amount >= 0 ? "arrow.up.right" : "arrow.down.right")
                    .foregroundColor(expense.amount >= 0 ? .green : .red)
                Text(String(format: "$%.2f", abs(expense.amount)))
                    .foregroundColor(expense.amount >= 0 ? .green : .red)
                    .bold()
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
    }

    func iconName(for category: String) -> String {
        switch category {
        case "Transportation": return "car.fill"
        case "Rent": return "house.fill"
        case "Pay": return "dollarsign.circle.fill"
        case "Gift": return "gift.fill"
        default: return "tag.fill"
        }
    }
}
