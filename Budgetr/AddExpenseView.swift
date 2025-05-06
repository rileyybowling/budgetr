import SwiftUI
import SwiftData

struct AddExpenseView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var category: String = ""
    @State private var customCategory: String = ""
    @State private var amount: String = ""
    @State private var isIncome: Bool = false
    @State private var date: Date = Date()
    @State private var showAlert = false
    
    @EnvironmentObject var expenseStorage: ExpenseStorage
    @EnvironmentObject var budgetStorage: BudgetStorage
    
    
    var categories = ["Groceries", "Dining Out", "Personal Spending", "Transportation", "Insurance", "Travel", "Medical", "Debt Payoff", "Tuition", "Rent", "Utilities", "Mortgage", "Other", "Work", "Gift", "Pay", "Unknown"]
    
    var amountValue: Double {
        Double(amount) ?? 0.0
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Category")) {
                    Picker("Select category", selection: $category) {
                        ForEach(categories, id: \.self) { category in
                            Text(category)
                                .font(.custom("Avenir", size: 15))
                        }
                    }
                    .font(.custom("Avenir", size: 20))
                    .pickerStyle(.menu)
                    if category == "Other" {
                        TextField("Enter custom category", text: $customCategory)
                            .font(.custom("Avenir", size: 20))
                    }
                }
                Section(header: Text("Amount (income will go into budget)")) {
                    TextField("Enter amount", text: $amount)
                        .font(.custom("Avenir", size: 20))
                        .keyboardType(.decimalPad)
                    
                    Toggle("Is this income?", isOn: $isIncome)
                        .font(.custom("Avenir", size: 20))
                }
                .font(.custom("Avenir", size: 12))
                Section(header: Text("Date")) {
                    DatePicker("Select date", selection: $date, displayedComponents: .date)
                        .font(.custom("Avenir", size: 20))
                }
                .font(.custom("Avenir", size: 12))
                Section {
                    VStack {
                        if category.isEmpty {
                            Text("Please enter a category.")
                                .font(.custom("Avenir", size: 20))
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                        if amount.isEmpty {
                            Text("Please enter a dollar amount.")
                                .font(.custom("Avenir", size: 20))
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                        if (!category.isEmpty && !amount.isEmpty){
                            Button("Cancel") {
                                dismiss()
                            }
                            .font(.custom("Avenir", size: 20))
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .foregroundColor(Color(hex: 0x9B8BF4))
                            .cornerRadius(8)
                            
                            Button("Save") {
                                addExpense()
                            }
                            .font(.custom("Avenir", size: 20))
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
                    Text("Add Expense")
                        .font(.custom("Avenir", size: 37))
                        .bold()
                }
            }
        }
        .environmentObject(budgetStorage)
        .environmentObject(expenseStorage)
    }
    
    private func selectedCategory() -> String {
        return category == "Other" ? customCategory : category
    }
    
    private func addExpense() {
        let finalAmount = isIncome ? amountValue : -amountValue
        let newExpense = Expense(category: selectedCategory(), amount: finalAmount, date: date)
        budgetStorage.budget?.left += finalAmount
        modelContext.insert(newExpense)
        expenseStorage.expenses.append(newExpense)
        dismiss()
    }
}

#Preview {
    AddExpenseView()
}
