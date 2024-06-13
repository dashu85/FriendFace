//
//  DetailView.swift
//  FriendFace
//
//  Created by Marcus Benoit on 06.06.24.
//

import Foundation
import SwiftData
import SwiftUI

struct DetailView: View {
    @Environment(\.modelContext) var modelContext
    
    var user: User
    var users: [User]
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading) {
                Section {
                    //Text("ID: ").bold() + Text(user.id)
                    Text("Company: ").bold() + Text(user.company)
                    Text("Registered: ").bold() + Text("\(user.date?.formatted(date: .abbreviated, time: .shortened) ?? "")")
                    Text("Address: ").bold() + Text(user.address)
                    Text("Current Age: ").bold() + Text("\(user.age)")
                } header: {
                    Text("Details")
                        .font(.title)
                }
                
                Rectangle()
                    .frame(height: 2)
                    .foregroundStyle(.white)
                    .padding(.vertical)
                
                Section {
                    Text(user.about)
                } header: {
                    Text("About")
                        .font(.title)
                }
                
                Rectangle()
                    .frame(height: 2)
                    .foregroundStyle(.white)
                    .padding(.vertical)
                
                Section {
                    ForEach(user.friends, id: \.id) { friendID in
                        if let friend = users.first(where: { $0.id == friendID.id }) {
                            NavigationLink(value: friend) {
                                Text(friendID.name)
                            }
                        }
                    }
                } header: {
                    Text("Friends: \(user.friends.count)")
                        .font(.title)
                }
            }
            .navigationTitle(user.name)
            .padding()
        }
        .background(backgroundGradient)
        .foregroundStyle(.black)
        .preferredColorScheme(.dark)
    }
}

//#Preview {
//    DetailView()
//}
