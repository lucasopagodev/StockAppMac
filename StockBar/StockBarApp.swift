//
//  StockBarApp.swift
//  StockBar
//
//  Created by Lucas Rodrigues on 18/10/24.
//
import SwiftUI

@main
struct MyStockApp: App {
    var body: some Scene {
        MenuBarExtra("Stocks", systemImage: "chart.bar") {
            ContentView()
                .frame(width: 300, height: 400) // Ajuste o tamanho da janela conforme necessário
        }
    }
}
