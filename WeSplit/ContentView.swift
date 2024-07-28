//
//  ContentView.swift
//  WeSplit
//
//  Created by Christopher Wade on 7/13/24.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20

    @FocusState private var amountIsFocused: Bool
    let tipPercentages = [10, 15, 20, 25, 0]
    let localeCode =  Locale.current.currency?.identifier ?? "USD"
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)

        let amountPerPerson = grandTotal / peopleCount

        return amountPerPerson
    }
    var grandTotal: Double {
        let tipSelection = Double(tipPercentage)

        let tipValue = checkAmount / 100.0 * tipSelection
        return checkAmount + tipValue
    }
    var body: some View {
        NavigationStack {
            Form {
                Section("Bill Information") {
                    TextField("Amount", value: $checkAmount, format: .currency(code: localeCode)) .keyboardType(.decimalPad).focused($amountIsFocused)

                    Picker("Number of People", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }.pickerStyle(.navigationLink)
                }
                Section("What tip would you like to leave?"){
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format:.percent)
                        }
                    }.pickerStyle(.navigationLink)
                }
                Section("Check Total") {
                    Text(grandTotal, format:.currency(code: localeCode))
                }
                Section("Total owed per person:") {
                    Text(totalPerPerson, format: .currency(code: localeCode))
                }
            }.navigationTitle("WeSplit")
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
