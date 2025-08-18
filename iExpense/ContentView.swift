//
//  ContentView.swift
//  iExpense
//
//  Created by ardano on 16.08.2025.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        
        items = []
    }
}

struct AmountText: View {
    var amount: Double
    var body: some View {
        switch amount {
        case 0...200:
            Text(amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                .font(.body)
                .foregroundStyle(.secondary)
        case 201...500:
            Text(amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                .font(.title3)
        default:
            Text(amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                .font(.title)
                .monospacedDigit()
                .bold()
        }
    }
}

struct ContentView: View {
    @State private var expenses = Expenses()
    
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationStack {
            List {
                Section("Personal") {
                    ForEach(expenses.items.filter {$0.type == "Personal"}) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            
                            Spacer()
                            AmountText(amount: item.amount)
                                .bold()
                        }
                    }
                    .onDelete(perform: removePersonal)
                }
                
                Section("Business") {
                    ForEach(expenses.items.filter {$0.type == "Business"}) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            
                            Spacer()
                            AmountText(amount: item.amount)
                                .bold()
                        }
                    }
                    .onDelete(perform: removeBusiness)
                }

            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    showingAddExpense = true
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    
    func removePersonal(at offsets: IndexSet) {
        let personalItems = expenses.items.filter { $0.type == "Personal"}
        for index in offsets {
            let item = personalItems[index]
            if let mainIndex = expenses.items.firstIndex(where: { $0.id == item.id }) {
                expenses.items.remove(at: mainIndex)
            }
        }
    }
    
    func removeBusiness(at offsets: IndexSet) {
        let personalItems = expenses.items.filter { $0.type == "Business"}
        for index in offsets {
            let item = personalItems[index]
            if let mainIndex = expenses.items.firstIndex(where: { $0.id == item.id }) {
                expenses.items.remove(at: mainIndex)
            }
        }
    }
}

#Preview {
    ContentView()
}
