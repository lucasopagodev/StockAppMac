//
//  Stock.swift
//  StockBar
//
//  Created by Lucas Rodrigues on 21/10/24.
//

import Foundation

struct Stock: Identifiable {
    let id = UUID()
    let name: String
    let price: Double
}

struct StockData: Decodable {
    let c: Double // Current Price
    let h: Double // High Price
    let l: Double // Low Price
    let o: Double // Open Price
    let pc: Double // Previous Close Price
}
