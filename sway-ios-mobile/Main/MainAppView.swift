//
//  MainAppView.swift
//  sway-ios-mobile
//
//  Created by Matija Brnas on 20.12.2023..
//

import SwiftUI


struct MainAppView: View {
    @State private var isLoggedIn: Bool = true
    @StateObject private var viewModel = PostsViewModel() // Create the viewModel here


    var body: some View {
        TabView {
            NavigationView {
                PostsView(logoutAction: {
                    self.isLoggedIn = false
                })
                .onAppear {
                    if viewModel.posts.isEmpty {
                        viewModel.fetchPosts()
                    }
                }
                .tabItem {
                    Label("Posts", systemImage: "number.circle.fill")
                }
            }

            DashboardView(logoutAction: {
                self.isLoggedIn = false
            })
            .tabItem {
                Label("Dashboard", systemImage: "lock.doc")
            }
        }
        .onAppear {
          
        }
    }
}

