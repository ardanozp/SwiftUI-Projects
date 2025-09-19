//
//  ContentView.swift
//  Friendface
//
//  Created by ardano on 18.09.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var users: [User] = []
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(users) { user in
                    NavigationLink(value: user) {
                        HStack {
                            Text(user.name)
                            Image(systemName: user.isActive ? "checkmark.circle.fill" : "circle")
                                .foregroundStyle(.blue)
                        }
                    }
                }
            }
            .task {
                if !users.isEmpty { return }
                else {
                    await loadData()
                }
            }
            .navigationDestination(for: User.self) { user in
                UserDetailView(user: user)
            }
        }
    }
    @MainActor
    func loadData() async {
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try decoder.decode([User].self, from: data)
            users = decoded
            
        } catch {
            print("Network decode error", error)
        }
    }
}

#Preview {
    ContentView()
}
