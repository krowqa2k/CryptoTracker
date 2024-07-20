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
                HStack {
                    ForEach(vm.statistics) { stat in
                        StatisticView(stat: stat)
                            .frame(width: (UIScreen.main.bounds.width / 3.12))
                    }
                }
                .frame(width: UIScreen.main.bounds.width, alignment: showPortfolio ? .trailing : .leading)
            }
            .frame(maxWidth: 360)
            .frame(maxHeight: 100)
            .background(Color.theme.background)
            .cornerRadius(12)
            .shadow(color:Color.theme.accent ,radius: 2)
        }
    }

#Preview {
    HomeStatsView(showPortfolio: .constant(false))
        .environmentObject(HomeViewModel())
}
