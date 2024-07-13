//
//  HomeView.swift
//  CryptoTracker
//
//  Created by admin on 13/07/2024.
//

import SwiftUI

struct HomeView: View {
    
    @State private var showPortfolio: Bool = false
    
    var body: some View {
        VStack {
            homeHeader
                .padding(.horizontal)
                Spacer(minLength: 0)
        }
        .background(Color.theme.background)
    }
}

#Preview {
    HomeView()
}

extension HomeView {
    
    private var homeHeader: some View {
        HStack {
            RoundedRectangleButtonView(iconName: showPortfolio ? "plus" : "info")
                .animation(.none, value: showPortfolio)
            Spacer()
            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .foregroundStyle(Color.theme.accent)
                .animation(.none, value: showPortfolio)
            Spacer()
            RoundedRectangleButtonView(iconName: "chevron.right")
                .rotationEffect(.degrees(showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring) {
                        showPortfolio.toggle()
                    }
                }
        }
    }
    
}
