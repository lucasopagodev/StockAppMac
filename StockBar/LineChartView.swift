//
//  LineChartView.swift
//  StockBar
//
//  Created by Lucas Rodrigues on 18/10/24.
//
import SwiftUI

struct LineChartView: View {
    let data: [Double]
    let title: String

    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
                .padding()
            
            Line(data: data)
                .frame(height: 200)
                .padding()
        }
    }
}

struct Line: View {
    var data: [Double]

    var body: some View {
        GeometryReader { geometry in
            Path { path in
                guard !data.isEmpty else { return }

                let stepWidth = geometry.size.width / CGFloat(data.count - 1)
                let maxValue = data.max() ?? 1
                let minValue = data.min() ?? 0
                let yRange = maxValue - minValue

                path.move(to: CGPoint(x: 0, y: geometry.size.height * (1 - CGFloat((data[0] - minValue) / yRange))))

                for index in data.indices {
                    let x = CGFloat(index) * stepWidth
                    let y = geometry.size.height * (1 - CGFloat((data[index] - minValue) / yRange))
                    path.addLine(to: CGPoint(x: x, y: y))
                }
            }
            .stroke(Color.blue, lineWidth: 2)
        }
    }
}
