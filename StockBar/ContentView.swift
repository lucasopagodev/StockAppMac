//
//  ContentView.swift
//  StockBar
//
//  Created by Lucas Rodrigues on 18/10/24.
//
import SwiftUI

struct ContentView: View {
    @State private var selectedSymbol: String = "AAPL" // Valor padrão
    @State private var stockPrices: [Double] = []
    @State private var stockData: [Stock] = []
    
    private let symbols = ["AAPL", "GOOGL", "MSFT", "AMZN", "TSLA"] // Adicione mais símbolos conforme necessário

    var body: some View {
        VStack {
            Picker("Select a Stock", selection: $selectedSymbol) {
                ForEach(symbols, id: \.self) { symbol in
                    Text(symbol).tag(symbol)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .onChange(of: selectedSymbol) { oldValue, newValue in
                fetchStockData(for: newValue)
                // fetchStockQuote(symbol: "AAPL", token: "csgh0v9r01qldu0corl0csgh0v9r01qldu0corlg")
            }
            .padding()

            if !stockData.isEmpty {
                LineChartView(data: stockPrices, title: "Stock Prices - \(selectedSymbol)")
                                .frame(height: 300)
                                .padding()
                
                StockChartView(stockData: stockData)
                    .frame(height: 300) // Ajuste a altura do gráfico conforme necessário
            } else {
                Text("Select a stock to see the data.")
                    .padding()
            }
        }
        .padding()
    }
    
    private func fetchStockData(for symbol: String) {
        let apiKey = "csgh0v9r01qldu0corl0csgh0v9r01qldu0corlg" // Substitua pela sua chave de API Finnhub
        guard let url = URL(string: "https://finnhub.io/api/v1/quote?symbol=\(symbol)&token=\(apiKey)") else {
            print("Erro: URL inválida.")
            return
        }
        
            
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Erro ao buscar os dados: \(error?.localizedDescription ?? "Erro desconhecido")")
                return
            }

            do {
                // Decodificando a resposta da API para um objeto de dados de cotação
                let response = try JSONDecoder().decode(StockData.self, from: data)
                DispatchQueue.main.async {
                    // Atualizando `stockPrices` para o `LineChartView`
                    self.stockPrices = [response.c, response.h, response.l, response.o, response.pc]
                    print(stockPrices)
                    // Atualiza o gráfico com os dados recebidos
                    self.stockData = [
                        Stock(name: "Current Price", price: response.c),
                        Stock(name: "High Price", price: response.h),
                        Stock(name: "Low Price", price: response.l),
                        Stock(name: "Open Price", price: response.o),
                        Stock(name: "Previous Close Price", price: response.pc)
                    ]
                }
            } catch {
                print("Erro ao decodificar os dados: \(error)")
            }
        }.resume() // Importante! Necessário para iniciar a tarefa
    }
}
