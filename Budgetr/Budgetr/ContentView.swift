//
//  ContentView.swift
//  Budgetr
//
//  Created by Riley Bowling on 3/12/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @StateObject var expenseStorage = ExpenseStorage()
    @StateObject private var budgetStorage = BudgetStorage()
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("Budgetr")
                        .bold()
                        .padding(.leading, 10)
                        .font(.custom("Avenir", size: 20))
                    Spacer()
                    NavigationLink(destination: ActivityView()) {
                        Label("", systemImage: "bell.fill")
                    }
                    .padding(10)
                    .foregroundStyle(Color.black)
//                    NavigationLink(destination: BudgetView()) {
//                        Label("", systemImage: "bell.fill")
//                    }
//                    .padding(10)
//                    .foregroundStyle(Color.black)
                }
                .frame(height: 75)
                .background(Color(hex: 0x9B8BF4).ignoresSafeArea())
                .clipShape(RoundedRectangle(cornerRadius: 12))
                
                ZStack {
                    if budgetStorage.budget != nil {
                        let progress = (budgetStorage.budget?.left ?? 0.0) / (budgetStorage.budget?.limit ?? 0.0)
                        // background circle (for total budget)
                        Circle()
                            .stroke(Color.red.opacity(0.5), lineWidth: 20)
                            .frame(width: 200, height: 200)
                        // foreground circle (for used budget)
                        Circle()
                            .trim(from: 0.0, to: progress)
                            .stroke(Color.green, lineWidth: 20)
                            .rotationEffect(.degrees(-90))
                            .frame(width: 200, height: 200)
                            .animation(.easeInOut, value: progress)
                    } else {
                        VStack(alignment: .center) {
                            Text("You do not have a budget.")
                                .font(.custom("Avenir", size: 25.0))
                                .padding()
                            Text("Click the wallet in the lower right-hand corner to begin")
                                .font(.custom("Avenir", size: 25.0))
                        }
                    }
                    
                }
                .padding()
                //recent activity
                ScrollView {
                    VStack(spacing: 16) {
                        let recentExpenses = expenseStorage.expenses.suffix(5).reversed()
                        ForEach(Array(recentExpenses), id: \.self) { expense in
                            HStack() {
                                Text("\(expense.category)")
                                    .font(.custom("Avenir", size: 20))
                                    .bold()
                                Text("$\(expense.amount, specifier: "%.2f")")
                                    .font(.custom("Avenir", size: 20))
                                Spacer()
                                Text("\(expense.date.formatted(.dateTime.month().day().year()))")
                                    .font(.custom("Avenir", size: 20))
                            }
                        }
                    }
                    .padding()
                }
                Spacer()
                // Bottom Navigation Bar
                HStack {
                    NavigationLink(destination: AddExpenseView()) {
                        VStack {
                            Image(systemName: "plus.square")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .foregroundColor(Color.black)
                            Text("Add Expense")
                                .font(.custom("Avenir", size: 12))
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
                                .font(.custom("Avenir", size: 12))
                                .foregroundColor(Color.black)
                        }
                        .frame(maxWidth: .infinity) // ✅
                    }
                    NavigationLink(destination: BudgetEditView()) {
                        VStack {
                            Image(systemName: "wallet.bifold")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .foregroundColor(Color.black)
                            Text("Budget")
                                .font(.custom("Avenir", size: 12))
                                .foregroundColor(Color.black)
                        }
                        .frame(maxWidth: .infinity) // ✅
                    }
                }
                .padding(.horizontal)
                .padding(.top, 8)
                .padding(.bottom, 12)
                .frame(height: 90)
                .background(Color(hex: 0x9B8BF4).ignoresSafeArea())
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(radius: 5)
            }
            .padding()
        }
        .environmentObject(expenseStorage)
        .environmentObject(budgetStorage)
    }
}

// completely unused?
//struct TransactionRow: View {
//    var expense: Expense
//    
//    var body: some View {
//        HStack {
//            Image(systemName: iconName(for: expense.category))
//                .font(.system(size: 24))
//                .foregroundColor(.blue)
//            
//            VStack(alignment: .leading) {
//                Text(expense.category)
//                    .font(.subheadline)
//                    .bold()
//            }
//            Spacer()
//            HStack {
//                Image(systemName: expense.amount >= 0 ? "arrow.up.right" : "arrow.down.right")
//                    .foregroundColor(expense.amount >= 0 ? .green : .red)
//                Text(String(format: "$%.2f", abs(expense.amount)))
//                    .foregroundColor(expense.amount >= 0 ? .green : .red)
//                    .bold()
//            }
//        }
//        .padding()
//        .background(Color(.secondarySystemBackground))
//        .cornerRadius(12)
//    }
//    
//    func iconName(for category: String) -> String {
//        switch category {
//        case "Transportation": return "car.fill"
//        case "Rent": return "house.fill"
//        case "Pay": return "dollarsign.circle.fill"
//        case "Gift": return "gift.fill"
//        default: return "tag.fill"
//        }
//    }
//}

extension Color {
    init(hex: Int) {
        self.init(
            red: Double((hex >> 16) & 0xFF) / 255.0,
            green: Double((hex >> 8) & 0xFF) / 255.0,
            blue: Double(hex & 0xFF) / 255.0
        )
    }
}

#Preview {
    ContentView()
}
