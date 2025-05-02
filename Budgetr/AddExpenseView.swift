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
    @State private var amount: String = ""
    @State private var date: Date = Date()
    
    var amountValue: Double {
        Double(amount) ?? 0.0
    }
    
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
                    DatePicker("Select date", selection: $date, displayedComponents: .date)
                }
                Section {
                    HStack {
                        Button("Cancel") {
                            dismiss()
                        }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                                            
                        Button("Save") {
                            addExpense()
                        }
                        .disabled(category.isEmpty ||   Double(amount) == nil)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                        }
                    }
                
            }
            .navigationTitle("Add Expense")
        }
    }
    
    
    private func addExpense(){
        guard let validAmount = Double(amount) else{
            return
        }
        
        let newExpense = Expense(category: category, amount: validAmount, date: date)
        modelContext.insert(newExpense)
        dismiss()
    }
}

#Preview {
    AddExpenseView()
}
