//
//  ActivityView.swift
//  Budgetr
//
//  Created by Riley Bowling on 5/5/25.
//

import SwiftUI

struct ActivityView: View {
    
    @EnvironmentObject var expenseStorage: ExpenseStorage
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(expenseStorage.expenses, id: \.self) { expense in
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
        }
        .environmentObject(expenseStorage)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Activity")
                    .font(.custom("Avenir", size: 37))
                    .bold()
            }
        }
    }
}

#Preview {
    ActivityView()
}
