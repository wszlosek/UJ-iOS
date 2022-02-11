//
//  ContentView.swift
//  4_BetterRest
//
//  Created by Wojciech Szlosek on 15/01/2022.
//

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = 0.0
    @State private var wakeUp = defaultWakeTime
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var body: some View {
        NavigationView {
            Form {
                Text("When do you want to wake up?")
                    .font(.headline)
                
                DatePicker("Please enter a time", selection: $wakeUp,
                           displayedComponents: .hourAndMinute)
                    .labelsHidden()
                
                Section("Desired amount of sleep") {
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }
                
                Section {
                    // Challenge 2
                    Picker("Daily coffee intake", selection: $coffeeAmount) {
                        ForEach(1..<10, id: \.self) {
                            Text(String($0) + " cap(s)")
                        }
                    }
                }
            }
            .navigationBarTitle("BetterRest")
            .toolbar {
                Button("Calculate", action: calculateBedtime)
            }
            .alert(alertTitle, isPresented: $showingAlert) {
                Button("Ok") { }
            } message: {
                Text(alertMessage)
                    .font(.largeTitle)
            }
        }
    }
    
    func calculateBedtime() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60 // in seconds
            let minute = (components.minute ?? 0) * 60 // in seconds
            
            let prediction = try model.prediction(wake: Double(hour + minute),
                estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            // powinienes isc spac o godzinie:
            let sleepTime = wakeUp - prediction.actualSleep
            alertTitle = "Your ideal bedtime is..."
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            alertTitle = "Error"
            alertMessage = " Problem with calculating your bedtime!"
        }
        
        showingAlert = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
