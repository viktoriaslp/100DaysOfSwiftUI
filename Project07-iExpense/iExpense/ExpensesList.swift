//
//  ExpensesList.swift
//  iExpense
//
//  Created by Victoria Slyunko on 16/6/25.
//

import SwiftData
import SwiftUI

struct ExpensesList: View {
    @Environment(\.modelContext) var modelContext
    @Query private var expenses: [ExpenseItem]
    
    let localCurrency = Locale.current.currency?.identifier ?? "USD"
    
    var body: some View {
        List {
            ForEach(expenses) { item in
                HStack {
                    VStack(alignment: .leading) {
                        Text(item.name)
                            .font(.headline)
                        
                        Text(item.type)
                    }
                    
                    Spacer()
                    
                    Text(item.amount, format: .currency(code: localCurrency))
                }
                // Day 76. Accessibility
                .accessibilityElement()
                .accessibilityLabel("\(item.name), \(item.amount.formatted(.currency(code: "USD")))")
                .accessibilityHint(item.type)
            }
            .onDelete(perform: removeItems)
        }
    }
    
    init(type: String = "All", sortOrder: [SortDescriptor<ExpenseItem>]) {
        _expenses = Query(filter: #Predicate<ExpenseItem> {
            if type == "All" {
                return true
            } else {
                return $0.type == type
            }
        }, sort: sortOrder)
    }
    
    func removeItems(at offsets: IndexSet) {
        for offset in offsets {
            let item = expenses[offset]
            modelContext.delete(item)
        }
    }
}

#Preview {
    ExpensesList(sortOrder: [SortDescriptor(\ExpenseItem.name)])
        .modelContainer(for: ExpenseItem.self)
}

