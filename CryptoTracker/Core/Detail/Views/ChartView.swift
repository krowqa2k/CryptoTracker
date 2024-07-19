//
//  ChartView.swift
//  CryptoTracker
//
//  Created by admin on 19/07/2024.
//

import SwiftUI
import Charts

struct ChartView: View {
    
    private let data: [Double]
    private let maxY: Double
    private let minY: Double
    private let lineColor: Color
    private let startingDate: Date
    private let endingDate: Date
    
    @State private var percentage: CGFloat = 0
    
    init(coin: CoinModel) {
        data = coin.sparklineIn7D?.price ?? []
        maxY = data.max() ?? 0
        minY = data.min() ?? 0
        
        let priceChange = (data.last ?? 0) - (data.first ?? 0)
        lineColor = priceChange > 0 ? Color.theme.green : Color.theme.red
        
        endingDate = Date(coinGeckoString: coin.lastUpdated ?? "")
        startingDate = endingDate.addingTimeInterval(-7*24*60*60)
    }
    
    var body: some View {
        VStack {
            chartView
                .frame(height: 200)
                .background(chartBackground)
            
            chartDateLabel
        }
        .font(.caption)
        .foregroundStyle(Color.theme.secondaryText)
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation(.linear(duration: 1.5)) {
                    percentage = 1.0
                }
            }
        })
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(coin: dev.coin)
    }
}

extension ChartView {
    private var chartView: some View {
        Chart {
            ForEach(data.indices, id: \.self) { index in
                LineMark(
                    x: .value("Date", Date(timeInterval: Double(index) * (7 * 24 * 60 * 60) / Double(data.count), since: startingDate)),
                    y: .value("Price", data[index])
                )
                .foregroundStyle(lineColor)
                .interpolationMethod(.catmullRom)
            }
        }
        .chartYScale(domain: minY...maxY)
        .chartXScale(domain: startingDate...endingDate)
    }
    
    private var chartBackground: some View {
        VStack{
            Divider()
            Spacer()
            Divider()
            Spacer()
            Divider()
        }
    }
    
    
    private var chartDateLabel: some View {
        HStack {
            Text(startingDate.asShortDateString())
            Spacer()
            Text(endingDate.asShortDateString())
        }
    }
}
