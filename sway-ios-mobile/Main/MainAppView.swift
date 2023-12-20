import SwiftUI

struct MainAppView: View {
    @State private var isLoggedIn: Bool = true
    @StateObject private var viewModel = PostsViewModel()

    // Add a callback to notify the parent view
    var onLogout: () -> Void

    var body: some View {
        TabView {
            NavigationView {
                PostsView(viewModel: viewModel, logoutAction: {
                    self.isLoggedIn = false
                    self.onLogout() // Notify the parent view when logging out
                })
                .onAppear {
                    if viewModel.posts.isEmpty {
                        viewModel.fetchPosts()
                    }
                }
            }
            .tabItem {
                Label("Posts", systemImage: "number.circle.fill")
            }

            NavigationView {
                DashboardView(logoutAction: {
                    self.isLoggedIn = false
                    self.onLogout() // Notify the parent view when logging out
                })
            }
            .tabItem {
                Label("Dashboard", systemImage: "lock.doc")
            }
        }
        .onAppear {
            // Any code that needs to run when this view appears
        }
    }
    
    // Initialize with a callback function
    init(onLogout: @escaping () -> Void) {
        self.onLogout = onLogout
    }
}
