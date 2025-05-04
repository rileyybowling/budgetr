struct AddExpenseView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @State private var category: String = ""
    @State private var customCategory: String = ""
    @State private var amount: String = ""
    @State private var isIncome: Bool = false
    @State private var date: Date = Date()

    let categories = ["Groceries", "Dining Out", "Personal Spending", "Transportation", "Insurance", "Travel", "Medical", "Debt Payoff", "Tuition", "Rent", "Utilities", "Mortgage", "Other", "Work", "Gift", "Pay"]
    
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
                        }
                    }
                    .pickerStyle(.menu)

                    if category == "Other" {
                        TextField("Enter custom category", text: $customCategory)
                    }
                }
        
                Section(header: Text("Amount")) {
                    TextField("Enter amount", text: $amount)
                        .keyboardType(.decimalPad)
                    
                    Toggle("Is this income?", isOn: $isIncome)
                }

                Section(header: Text("Date")) {
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

    private func selectedCategory() -> String {
        return category == "Other" ? customCategory : category
    }

    private func addExpense() {
        guard let validAmount = Double(amount) else {
            return
        }

        let finalAmount = isIncome ? validAmount : -validAmount

        let newExpense = Expense(category: selectedCategory(), amount: finalAmount, date: date)
        modelContext.insert(newExpense)
        dismiss()
    }
}

#Preview {
    AddExpenseView()
}
