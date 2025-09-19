//
//  UserDetailView.swift
//  Friendface
//
//  Created by ardano on 18.09.2025.
//

import SwiftUI

struct UserDetailView: View {
    let user: User
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                //Header
                VStack(spacing: 16) {
                    HStack(spacing: 12) {
                        Image(systemName: user.isActive ? "checkmark.circle.fill" : "circle")
                            .font(.title2)
                            .foregroundStyle(.blue)
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text(user.name)
                                .font(.title3)
                                .fontWeight(.semibold)
                            Text(user.company)
                                .font(.footnote)
                                .foregroundStyle(.secondary)
                                .italic()
                        }
                    }
                    .padding(.top, 54)
                    
                    GroupBox {
                        VStack(alignment: .leading, spacing: 8) {
                            Label(user.email, systemImage: "envelope")
                            Label(user.address, systemImage: "mappin.and.ellipse")
                            Label(user.registered, style: .date, icon: "calendar")
                        }
                    }
                    
                    .padding(.top, 16)
                    .padding(.bottom, 46)
                    
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
                
                //About
                VStack(alignment: .leading, spacing: 16) {
                    Text("ABOUT")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .padding(.bottom, -12)
                    
                        Text(user.about)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 24)
                .padding(.bottom, 24)
                
                //Tags
                VStack(alignment: .leading, spacing: 16) {
                    Text("TAGS")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .padding(.bottom, -6)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(user.tags, id: \.self) { tag in
                                VStack(alignment: .leading) {
                                    Text(tag)
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                                .padding(.vertical, 8)
                                .padding(.horizontal, 12)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(8)
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 24)
                .padding(.bottom, 24)
                
                VStack(alignment: .leading, spacing: 16) {
                    Text("FRIENDS (\(user.friends.count))")
                        .font(.headline)
                        .foregroundStyle(.secondary)
                        .padding(.bottom, -6)
                    
                    VStack(spacing: 10) {
                        ForEach(user.friends, id: \.self) { friend in
                            HStack {
                                Image(systemName: "person")
                                Text(friend.name)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 24)
                .padding(.bottom, 24)
            }
        }
    }
}

extension Label where Title == Text, Icon == Image {
    init(_ date: Date, style: Text.DateStyle, icon: String) {
        self.init {
            Text(date, style: style)
        } icon: {
            Image(systemName: icon)
        }
    }
}


#Preview {
    UserDetailView(user: User.example)
}
