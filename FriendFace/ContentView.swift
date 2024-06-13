//
//  ContentView.swift
//  FriendFace
//
//  Created by Marcus Benoit on 04.06.24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \User.name) var users: [User]
    
    @AppStorage("lastFetched")  var lastFetched: Double = Date.now.timeIntervalSinceReferenceDate
    
    @State private var isLoading: Bool = false
    
//    @State private var path = PathStore()
    @State private var path = NavigationPath()

    init() {
            // Set the large title text colour for the entire app
            UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.black]
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                backgroundGradient
                List {
                    ForEach(users, id: \.id) { user in
                        Section {
                            NavigationLink(value: user) {
                                HStack {
                                    Text(user.name)
                                        .font(.title2)
                                    user.isActive ? Text("online").foregroundStyle(.green) : Text("offline").foregroundStyle(.red)
                                        .font(.body)
                                }
                            }
                        }
                        .padding(2)
                        .listSectionSpacing(5)
                    }
                }
                .navigationTitle("FriendFace")
                .navigationDestination(for: User.self) { user in
                    DetailView(user: user, users: users)
                }
                .opacity(0.8)
                .background(backgroundGradient)
                .scrollContentBackground(.hidden)
            }
            .preferredColorScheme(.dark)
            .task {
                do {
                    isLoading = true
                    defer{
                        isLoading = false
                    }
                    
                    if hasExceededTimeLimit() || users.isEmpty {
                        clearDatabase()
                        try await fetchJSON()
                    }
                } catch {
                    print(error)
                }
            }
            .overlay {
                if isLoading {
                    ProgressView()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
