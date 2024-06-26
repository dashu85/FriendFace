//
//  FriendFaceApp.swift
//  FriendFace
//
//  Created by Marcus Benoit on 04.06.24.
//

import SwiftData
import SwiftUI

@main
struct FriendFaceApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
