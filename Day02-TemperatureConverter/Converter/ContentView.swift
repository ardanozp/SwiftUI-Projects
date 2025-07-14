//
//  ContentView.swift
//  Converter
//
//  Created by ardano on 14.07.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var userInput = 0.0
    @State private var inputUnit = "Celcius"
    @State private var outputUnit = "Celcius"
    
    var convertedValue: Double {
        var celciusValue: Double
        
        switch inputUnit {
        case "Fahrenheit":
            celciusValue = (userInput - 32) * 5 / 9
        case "Kelvin":
            celciusValue = userInput - 273.15
        default:
            celciusValue = userInput
        }
        
        switch outputUnit {
        case "Fahrenheit":
            return celciusValue * 9 / 5 + 32
        case "Kelvin":
            return celciusValue + 273.15
        default:
            return celciusValue
        }
   
    }
    
    let tempertureType = ["Celcius", "Fahrenheit", "Kelvin"]
    var body: some View {
        VStack {
            Form {
                Section("Input") {
                    TextField("Number", value: $userInput, format: .number.rounded())
                    
                    
                    Picker("Unit", selection: $inputUnit) {
                        ForEach(tempertureType, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Output") {
                    Text(convertedValue, format: .number.rounded())
                    Picker("Unit", selection: $outputUnit) {
                        ForEach(tempertureType, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
