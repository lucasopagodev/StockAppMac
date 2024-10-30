//
//  FinnhubResponse.swift
//  StockBar
//
//  Created by Lucas Rodrigues on 21/10/24.
//

struct FinnhubResponse: Codable {
    let c: Double // Preço atual
    let h: Double // Preço máximo do dia
    let l: Double // Preço mínimo do dia
    let o: Double // Preço de abertura do dia
    let pc: Double // Fechamento anterior
}
