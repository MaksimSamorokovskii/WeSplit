//
//  ContentView.swift
//  WeSplit
//
//  Created by Максим Самороковский on 05.02.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipValue = checkAmount / 100 * Double(tipPercentage)
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var totalAmountWithTip: Double {
        let tipValue = checkAmount / 100 * Double(tipPercentage)
        let amountTip = checkAmount + tipValue
        
        return amountTip
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
                    .pickerStyle(.navigationLink)
                }
                
                // Third task: replace the segment with a new screen with a percentage
                Section("How much tip do you want to leave?") {
                    Picker("Choose percentage", selection: $tipPercentage) {
                        ForEach(0..<101) {
                            Text("\($0) %")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }

                // Second task: add a section showing the total amount plus tip
                Section("Total amount with tip") {
                    Text(totalAmountWithTip, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                
                // First task: add a title to the third section
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
