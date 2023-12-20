//
//  MainAppView.swift
//  sway-ios-mobile
//
//  Created by Matija Brnas on 20.12.2023..
//

import SwiftUI

struct MainAppView: View {
    @State private var isLoggedIn: Bool = true

    var body: some View {
        TabView {
            PostsView(logoutAction: {
                self.isLoggedIn = false
            })
            .tabItem {
                Label("Posts", systemImage: "number.circle.fill")
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
