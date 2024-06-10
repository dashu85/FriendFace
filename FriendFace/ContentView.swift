//
//  ContentView.swift
//  FriendFace
//
//  Created by Marcus Benoit on 04.06.24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @State private var users = [User]()
    @State private var isOnline = true
    
    @State private var path = PathStore()

    init() {
            // Set the large title text color for the entire app
            UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        }
    
    var body: some View {
        NavigationStack(path: $path.path) {
            ZStack {
                backgroundGradient
                List {
                    ForEach(users) { user in
                        Section {
                            NavigationLink(value: user) {
                                HStack {
                                    Text(user.name)
                                        .font(.title2)
                                    user.isActive ? Text("online").foregroundStyle(.green) : Text("offline").foregroundStyle(.red)
                                        .font(.body)
                                    
                                    // UserDefaults.standard.set(order.name, forKey: "path")
                                }
                            }
                        }
                        .padding(2)
                        .listSectionSpacing(5)
                    }
                }
                .opacity(0.8)
                .background(backgroundGradient)
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("FriendFace")
            .navigationDestination(for: User.self) { user in
                DetailView(user: user, users: users, friendsArray: [User]())
            }
            .preferredColorScheme(.dark)
            .task {
                await fetchData()
            }
        }
    }
    
    
    
    func fetchData() async {
        // create url
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("failed to load url")
            return
        }
        
        // fetch data from that url
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            // decode that data
            if let decodedResponse = try? JSONDecoder().decode([User].self, from: data) {
                users = decodedResponse
            }
        } catch {
            print("didn't work")
        }
    }
}

#Preview {
    ContentView()
}
