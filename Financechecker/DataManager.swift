import Foundation
import Combine

class DataManager: ObservableObject {
    static let shared = DataManager()
    
    @Published var expenses: [Expense] = []
    
    
    private init() {}
    
    func addExpense(_ expense: Expense) {
        expenses.append(expense)
    }
    
    func removeExpenses(_ expensesToRemove: [Expense]) {
        self.expenses.removeAll { expenseToRemove in
            return expensesToRemove.contains(where: { $0.id == expenseToRemove.id })
        }
    }
}

func deleteExpenses(dataManager: DataManager, expensesToRemove: [Expense]) {
    dataManager.removeExpenses(expensesToRemove)
}
