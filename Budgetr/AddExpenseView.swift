//
//  AddExpenseView.swift
//  Budgetr
//
//  Created by Riley Bowling on 4/10/25.
//
//
//

import SwiftUI
import SwiftData

struct AddExpenseView: View {
    
    //persisting data
    @Environment(\.modelContext) private var modelContext
    
    @Environment(\.dismiss) private var dismiss
    @State private var category: String = ""
    @State private var amount: Double = 0.0
    @State private var date: Date = Date()
    
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text ("Category")){
                    TextField("Enter category", text: $category)
                }

                Section(header: Text("Amount")){
                    TextField("Enter amount", text: $amount)
                    .keyboardType(.decimalPad)
                }

                Section(header: Text("Date")){
                    TextField("Select date", selection $date, displayedComponents: .date)
                }

            }
        }
    }
}

#Preview {
    AddExpenseView()
}
