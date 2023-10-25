//
//  ManualVals.swift
//  Splitster2
//
//  Created by Tang Favish on 9/21/23.
//

import SwiftUI

struct ManualVals: View {
    @State private var items = [Item]()
    @State private var taxPercentage = ""
    @State private var tipPercentage = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Items")) {
                    ForEach(items.indices, id: \.self) { index in
                        HStack {
                            TextField("Item", text: $items[index].name)
                            TextField("Cost", text: $items[index].cost)
                                .keyboardType(.decimalPad)
                        }
                    }
                    Button("Add Item") {
                        self.items.append(Item(name: "", cost: ""))
                    }
                }
                
                Section {
                    TextField("Tax Percentage", text: $taxPercentage)
                        .keyboardType(.decimalPad)
                    TextField("Tip Percentage", text: $tipPercentage)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("Results")) {
                    ForEach(items.indices, id: \.self) { index in
                        let cost = Double(items[index].cost) ?? 0
                        let totalCost = items.reduce(0) { $0 + (Double($1.cost) ?? 0) }
                        let tax = (Double(taxPercentage) ?? 0) / 100 * totalCost
                        let tip = (Double(tipPercentage) ?? 0) / 100 * totalCost
                        
                        let individualShare = totalCost == 0 ? 0 : (tax + tip + totalCost) * (cost / totalCost)
                        
                        Text("\(items[index].name): \(String(format: "%.2f", individualShare))")
                    }
                }
            }
            .navigationBarTitle("Manual Vals", displayMode: .inline)
        }
    }
    
    struct Item {
        var name: String
        var cost: String
    }
}
