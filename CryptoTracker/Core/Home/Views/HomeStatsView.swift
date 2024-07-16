//
//  HomeStatsView.swift
//  CryptoTracker
//
//  Created by admin on 16/07/2024.
//

import SwiftUI

struct HomeStatsView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @Binding var showPortfolio: Bool
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 12)
                .frame(width: 385, height: 250)
                .foregroundStyle(Color.theme.background)
                .shadow(color:Color.theme.accent ,radius: 5)
                .overlay {
                    HStack {
                        ForEach(vm.statistics) { stat in
                            StatisticView(stat: stat)
                                .frame(width: UIScreen.main.bounds.width / 3.12)
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width, alignment: showPortfolio ? .trailing : .leading)
                }
        }
        .padding(.horizontal)
    }
}

#Preview {
    HomeStatsView(showPortfolio: .constant(false))
        .environmentObject(HomeViewModel())
}
