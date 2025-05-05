//
//  BudgetEditView.swift
//  Budgetr
//
//  Created by Riley Bowling on 4/10/25.
//

import SwiftUI
import SwiftData

struct BudgetEditView: View {
    
    @State private var amount: String = ""
    @State private var name: String = ""
    var amountValue: Double {
        Double(amount) ?? 0.0
    }
    
    //persisting data
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var budgetStorage = BudgetStorage()
    
    var body: some View {
        if budgetStorage.budget == nil {
            NavigationView {
                Form {
                    Section {
                        Text("  You do not have a budget.\nWould you like to create one?")
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    Section(header: Text("Name ex. October 2024, Spring '25, etc.")) {
                        TextField("Enter name", text: $name)
                            .keyboardType(.decimalPad)
                    }
                    Section(header: Text("Amount")) {
                        TextField("Enter amount", text: $amount)
                            .keyboardType(.decimalPad)
                    }
                    Section {
                        VStack {
                            if name.isEmpty {
                                Text("Please enter a name.")
                                    .frame(maxWidth: .infinity, alignment: .center)
                            }
                            if amount.isEmpty {
                                Text("Please enter a dollar amount.")
                                    .frame(maxWidth: .infinity, alignment: .center)
                            }
                            if (!name.isEmpty && !amount.isEmpty){
                                Button("Cancel") {
                                    dismiss()
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.gray.opacity(0.2))
                                .foregroundColor(Color(hex: 0x9B8BF4))
                                .cornerRadius(8)
                                
                                Button("Save") {
                                    budgetStorage.budget = Budget(name: name, limit: amountValue)
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(hex: 0x9B8BF4))
                                .foregroundColor(.white)
                                .cornerRadius(8)
                            }
                        }
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Budget")
                            .font(.custom("Avenir", size: 37))
                            .bold()
                    }
                }
            }
            
        } else {
            NavigationView {
                Form {
                    Section(header: Text("Name")) {
                        Text(budgetStorage.budget?.name ?? "")
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Budget")
                            .font(.custom("Avenir", size: 37))
                            .bold()
                    }
                }
            }
        }
    }
}

#Preview {
    BudgetEditView()
}
