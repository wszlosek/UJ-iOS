//
//  ExpenseItem.swift
//  7_iExpense
//
//  Created by Wojciech Szlosek on 01/02/2022.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    let id = UUID()
    let name: String
    let type: String
    let amount: Double
}
