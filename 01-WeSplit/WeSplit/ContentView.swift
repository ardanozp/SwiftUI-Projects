//
//  ContentView.swift
//  WeSplit
//
//  Created by ardano on 10.07.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool

    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var grandTotal: Double {
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        
        return checkAmount + tipValue
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var body: some View {
        NavigationStack {
        Form {
            Section {
                TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)
                
                Picker("Number of people", selection: $numberOfPeople) {
                    ForEach(2..<100) {
                        Text("\($0) people")
                    }
                }
            }
            
            Section("How much tip do you want to leave?") {
                
                Picker("Tip percentage", selection: $tipPercentage) {
                    ForEach(0..<101) {
                        Text($0, format: .percent)
                    }
                }
                .pickerStyle(.navigationLink)
            }
            
            Section("Check Amount + Tip") {
                Text(grandTotal, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
            }
            
            Section("Amount per person") {
                Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
        .navigationTitle("WeSplit")
        .toolbar {
            if amountIsFocused {
                Button("Done") {
                    amountIsFocused = false
                }
            }
        }
        }
    }
}

#Preview {
    ContentView()
}
