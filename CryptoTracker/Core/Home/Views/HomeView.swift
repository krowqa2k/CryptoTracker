//
//  HomeView.swift
//  CryptoTracker
//
//  Created by admin on 13/07/2024.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @State private var showPortfolio: Bool = false
    @State private var showPortfolioView: Bool = false
    @State private var selectedCoin: CoinModel? = nil
    @State private var showDetailView: Bool = false
    
    var body: some View {
        VStack {
            homeHeader
                .padding(.horizontal)
                Spacer(minLength: 0)
            
            HomeStatsView(showPortfolio: $showPortfolio)
                .padding(.horizontal)
            
            SearchBarView(searchText: $vm.searchText)
                .padding()
            
            columnTitles
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
                .padding(.horizontal, 35)
            
            if !showPortfolio {
                allCoinsList
                    .transition(.move(edge: .leading))
                    .frame(maxWidth: .infinity)
                    .frame(maxHeight: .infinity)
                    .background(Color.theme.background)
                    .cornerRadius(12)
                    .shadow(color:Color.theme.accent ,radius: 3)
                    .padding(.horizontal)
            }
            if showPortfolio {
                portfolioCoinsList
                    .transition(.move(edge: .trailing))
                    .frame(maxWidth: .infinity)
                    .frame(maxHeight: .infinity)
                    .background(Color.theme.background)
                    .cornerRadius(12)
                    .shadow(color:Color.theme.accent ,radius: 3)
                    .padding(.horizontal)
            }
            
        }
        .background(Color.theme.background)
        .background(NavigationLink(
            destination: DetailLoadingView(coin: $selectedCoin),
            isActive: $showDetailView,
            label: { EmptyView() })
        )
        .sheet(isPresented: $showPortfolioView, content: {
            PortfolioView()
        })
    }
}

#Preview {
    HomeView()
        .environmentObject(HomeViewModel())
}

extension HomeView {
    
    private var homeHeader: some View {
        HStack {
            RoundedRectangleButtonView(iconName: showPortfolio ? "plus" : "info")
                .animation(.none, value: showPortfolio)
                .onTapGesture {
                    if showPortfolio {
                        showPortfolioView.toggle()
                    }
                }
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
    
    private var allCoinsList: some View {
        List {
            ForEach(vm.allCoins) { coin in
                    CoinRowView(coin: coin, showHoldingsColumn: false)
                        .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                        .onTapGesture {
                            segue(coin: coin)
                        }
            }
        }
        .listStyle(InsetListStyle())
    }
    
    private var portfolioCoinsList: some View {
        List {
            ForEach(vm.portfolioCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                    .onTapGesture {
                        segue(coin: coin)
                    }
            }
        }
        .listStyle(InsetListStyle())
    }
    
    private func segue(coin: CoinModel) {
        selectedCoin = coin
        showDetailView.toggle()
    }
    
    private var columnTitles: some View {
        HStack {
            HStack(spacing: 4) {
                Text("Coin")
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOption == .rank || vm.sortOption == .rankReversed) ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .rank ? 0 : 180))
            }
            .onTapGesture {
                if vm.sortOption == .rank {
                    vm.sortOption = .rankReversed
                } else {
                    vm.sortOption = .rank
                }
            }
            
            Spacer()
            if showPortfolio {
                HStack(spacing: 4) {
                    Text("Holdings")
                        .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
                    Image(systemName: "chevron.down")
                        .opacity((vm.sortOption == .holdings || vm.sortOption == .holdingsReversed) ? 1.0 : 0.0)
                        .rotationEffect(Angle(degrees: vm.sortOption == .holdings ? 0 : 180))
                }
                .onTapGesture {
                    if vm.sortOption == .holdings {
                        vm.sortOption = .holdingsReversed
                    } else {
                        vm.sortOption = .holdings
                    }
                }
            }
            HStack(spacing: 4) {
                Text("Price")
                    .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOption == .price || vm.sortOption == .priceReversed) ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .price ? 0 : 180))
            }
            .onTapGesture {
                if vm.sortOption == .price {
                    vm.sortOption = .priceReversed
                } else {
                    vm.sortOption = .price
                }
            }
        }
    }
}
