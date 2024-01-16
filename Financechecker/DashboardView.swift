import SwiftUI

struct DashboardView: View {
    @ObservedObject var dataManager = DataManager.shared
    @State private var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d/M/y"
        return formatter
    }()

    var body: some View {
        List {
            ForEach(groupedExpenses(), id: \.0) { date, expenses, totalAmount in
                Section(
                    header: Text("\(date, formatter: dateFormatter)")
                        .font(.system(size: 27, weight: .semibold))
                        .foregroundColor(.primary)
                        .padding(.bottom, 4),
                    footer: Text("Total Amount: \(String(format: "%.2f", totalAmount))")
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                        .padding(.top, 4)
                ) {
                    ForEach(expenses) { expense in
                        ExpenseListItemView(expense: expense, dataManager: dataManager)
                    }
                }
            }
        }
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        .listStyle(InsetGroupedListStyle())
    }

    func groupedExpenses() -> [(Date, [Expense], Double)] {
        let groupedDictionary = Dictionary(grouping: dataManager.expenses) { expense in
            Calendar.current.startOfDay(for: expense.date)
        }

        return groupedDictionary.map { key, value in
            let totalAmount = value.reduce(0) { $0 + $1.amount }
            return (key, value, totalAmount)
        }
    }
}

struct ExpenseListItemView: View {
    let expense: Expense
    let dataManager: DataManager

    var body: some View {
        HStack {
            Text("\(expense.category): \(formattedAmount)")
                .font(.system(size: 14))
                .foregroundColor(.primary)
                .lineLimit(1)
            Spacer()
            Text("Delete")
                .font(.system(size: 14))
                .foregroundColor(.red)
                .onTapGesture {
                    dataManager.removeExpenses([expense])
                }
        }
        .padding(8)
        .background(Color.clear)
        .cornerRadius(8)
    }

    var formattedAmount: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter.string(from: NSNumber(value: expense.amount)) ?? ""
    }
}
