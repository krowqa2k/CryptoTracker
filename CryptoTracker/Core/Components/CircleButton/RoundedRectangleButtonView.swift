//
//  CircleButtonView.swift
//  CryptoTracker
//
//  Created by admin on 13/07/2024.
//

import SwiftUI

struct RoundedRectangleButtonView: View {
    
    let iconName: String
    
    var body: some View {
        Image(systemName: iconName)
            .font(.headline)
            .foregroundStyle(Color.theme.accent)
            .frame(width: 50, height: 50)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .foregroundStyle(Color.theme.background)
            )
            .shadow(
                color: Color.theme.accent.opacity(0.25),
                radius: 10, x: 0, y: 0)
            .padding()
    }
}

#Preview {
    RoundedRectangleButtonView(iconName: "plus")
}
