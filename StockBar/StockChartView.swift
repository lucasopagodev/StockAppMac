//
//  StockChartView.swift
//  StockBar
//
//  Created by Lucas Rodrigues on 18/10/24.
//

import SwiftUI

struct StockChartView: View {
    let stockData: [Stock]
    
    var body: some View {
        VStack {
            Text("Stock Prices")
                .font(.headline)

            HStack {
                ForEach(stockData) { stock in
                    VStack {
                        Text(stock.name)
                        Text(String(format: "%.2f", stock.price))
                    }
                }
            }
        }
        .padding()
    }
}
