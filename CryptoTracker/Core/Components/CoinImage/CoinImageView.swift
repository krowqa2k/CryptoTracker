//
//  CoinImageView.swift
//  CryptoTracker
//
//  Created by admin on 15/07/2024.
//

import SwiftUI



struct CoinImageView: View {
    
    let coin: CoinModel
    
    var body: some View {
        ZStack{
            AsyncImage(url: URL(string: coin.image)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 35, height: 35)
        }
    }
}

struct CoinImageView_Previews: PreviewProvider {
    static var previews: some View {
        CoinRowView(coin: dev.coin, showHoldingsColumn: false)
    }
}
