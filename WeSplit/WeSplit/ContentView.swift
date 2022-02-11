//
//  ContentView.swift
//  WeSplit
//
//  Created by Wojciech Szlosek on 02/01/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 10
    
    var resultPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        return (checkAmount + checkAmount/100 * Double(tipPercentage)) / peopleCount
    }
    
    // Challenge 2-2:
    var totalAmount: Double {
        return checkAmount + checkAmount/100 * Double(tipPercentage)
    }
    
    let tipPercentages = [0, 10, 15, 20, 25]
    @FocusState private var amountIsFocused: Bool
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                // Challenge 3:
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<101) {
                            Text($0, format: .percent)
                        }
                    }
                } header: {
                    Text("How much tip do you want to leave?")
                }
                
                Section {
                    Text(resultPerPerson, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                } // Challenge 1:
                header: {
                    Text("Amount per person")
                }
                
                
                // Challenge 2:
                Section {
                    Text(totalAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                    // Challenge 1 z projektu 3
                        .foregroundColor(tipPercentage == 0 ? .red : .black)
                } header: {
                    Text("Total amount")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
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
