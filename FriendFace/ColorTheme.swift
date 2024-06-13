//
//  ColorTheme.swift
//  FriendFace
//
//  Created by Marcus Benoit on 06.06.24.
//

import Foundation
import SwiftUI

extension ShapeStyle where Self == Color {
    static var darkBackground: Color {
        Color(red: 0.1, green: 0.1, blue: 0.2)
    }
    
    static var lightBackground: Color {
        Color(red: 0.2, green: 0.2, blue: 0.3)
    }
}

let backgroundGradient = LinearGradient(
    colors: [Color.yellow, Color.orange, Color.red],
    startPoint: .top, endPoint: .bottom)

