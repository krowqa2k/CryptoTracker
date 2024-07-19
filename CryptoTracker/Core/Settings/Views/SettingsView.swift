//
//  SettingsView.swift
//  CryptoTracker
//
//  Created by admin on 19/07/2024.
//

import SwiftUI

struct SettingsView: View {
    
    let aboutMe = URL(string: "https://github.com/krowqa2k")!
    let coingeckoURL = URL(string: "https://www.coingecko.com")!
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationStack {
            List {
                Section("Info about me") {
                    HStack {
                        Image("me")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 100)
                        VStack (alignment: .leading,spacing: 10){
                            Text("App created by Mateusz Krówczyński.")
                                .font(.callout)
                                .fontWeight(.medium)
                                .foregroundStyle(Color.theme.accent)
                            Text("👇 You can reach me here.")
                                .font(.callout)
                                .fontWeight(.medium)
                                .foregroundStyle(Color.theme.accent)
                            Link("Github profile.", destination: aboutMe)
                                .foregroundStyle(.blue)
                        }
                    }
                }
                Section("COINGECKO") {
                    VStack(alignment: .leading) {
                        Image("coingecko")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                        
                        Text("The crypto app data that is used in this app comes from API from CoinGecko!")
                            .font(.callout)
                            .fontWeight(.medium)
                            .foregroundStyle(Color.theme.accent)
                            .padding(.vertical)
                    }
                    Link("Visit CoinGecko!", destination: coingeckoURL)
                        .foregroundStyle(.blue)
                }
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "xmark")
                    })
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}
