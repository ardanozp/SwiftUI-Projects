//
//  ContentView.swift
//  BetterRest
//
//  Created by ardano on 22.07.2025.
//

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeUp = defaultWakeTime
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
   
    @State private var sleepTime = Date()


    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    
    var body: some View {
        NavigationStack{
            Form {
                Section("When do you want to wake up?") {
                    
                DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .frame(maxWidth: .infinity, alignment: .center)
                    

                }
                
                Section("Desired amount of sleep") {
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }

                
                Section {
                    Picker("Daily coffee intake", selection: $coffeeAmount) {
                        ForEach(1..<21, id: \.self) { amount in
                            Text("\(amount) cup(s)")
                                .tag(amount)
                        }
                    }
                }
                
                VStack(spacing: 8) {
                    Text("Recommended Sleep Time")
                        .font(.headline)
                        .foregroundColor(.white)

                    Text(sleepTime.formatted(date: .omitted, time: .shortened))
                        .font(.system(size: 50, weight: .bold))
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity, maxHeight: 150)
                .padding()
                
            }
            .navigationTitle("BetterRest")
            .onChange(of: wakeUp) { _ in calculateBedtime() }
            .onChange(of: sleepAmount) { _ in calculateBedtime() }
            .onChange(of: coffeeAmount) { _ in calculateBedtime() }
        }

    }
    
    func calculateBedtime() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)

            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))

            sleepTime = wakeUp - prediction.actualSleep
            
            alertTitle = "Your ideal bedtime is…"
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)

        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
        }
        showingAlert = true

    }
}

#Preview {
    ContentView()
}

