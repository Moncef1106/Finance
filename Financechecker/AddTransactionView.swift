import SwiftUI

struct AddTransactionView: View {
    @State private var amount: String = ""
    @State private var category: String = ""
    @State private var notes: String = ""
    @ObservedObject var dataManager = DataManager.shared

    var body: some View {
        Form {
            Section(header: Text("Transaction Details")) {
                TextField("Amount", text: Binding(
                    get: { self.amount },
                    set: { newValue in
                        self.amount = self.formatAmountInput(newValue)
                    }
                ))
                .keyboardType(.decimalPad)

                TextField("Category", text: $category)
                TextField("Notes", text: $notes)
            }

            Section {
                Button(action: {
                    addTransaction()
                }) {
                    Text("Add Transaction")
                }
            }
        }
        .navigationTitle("Add Transaction")
    }

    private func formatAmountInput(_ input: String) -> String {
        var cleanedInput = input.replacingOccurrences(of: "[^0-9.,]", with: "", options: .regularExpression)

        cleanedInput = cleanedInput.replacingOccurrences(of: ",", with: ".")

        if let dotIndex = cleanedInput.firstIndex(of: ".") {
            let decimalPart = cleanedInput[dotIndex...]
            let decimalCount = decimalPart.count
            if decimalCount > 3 {
                cleanedInput = String(cleanedInput.prefix(upTo: cleanedInput.index(dotIndex, offsetBy: 4)))
            }
        }

        return cleanedInput
    }

    func addTransaction() {
        guard let amount = Double(amount), !category.isEmpty else {
            return
        }

        let newExpense = Expense(amount: amount, date: Date(), category: category, notes: notes)
        dataManager.addExpense(newExpense)

        self.amount = ""
        self.category = ""
        self.notes = ""
    }
}
