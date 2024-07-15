//
//  UIApplication.swift
//  CryptoTracker
//
//  Created by admin on 15/07/2024.
//

import Foundation
import SwiftUI

extension UIApplication {
    
    func endEditing(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}
