import SwiftUI

struct MainAppView: View {
    @State private var isLoggedIn: Bool = true
    @StateObject private var viewModel = PostsViewModel()

    // Callback to notify the parent view
    var onLogout: () -> Void

    var body: some View {
        TabView {
            // Posts tab
            NavigationView {
                PostsView(viewModel: viewModel, logoutAction: {
                    isLoggedIn = false
                    onLogout() // Notify the parent view when logging out
                })
                .navigationBarTitle("Posts", displayMode: .inline)
                .onAppear {
                    if viewModel.posts.isEmpty {
                        viewModel.fetchPosts()
                    }
                }
            }
            .tabItem {
                Label("Posts", systemImage: "number.circle.fill")
            }

            // Dashboard tab
            NavigationView {
                DashboardView(logoutAction: {
                    isLoggedIn = false
                    onLogout() // Notify the parent view when logging out
                })
                .navigationBarTitle("Dashboard", displayMode: .inline)
            }
            .tabItem {
                Label("Dashboard", systemImage: "lock.doc")
            }

            // Create post tab
            NavigationView {
                CreatePostView() // This is your new view for creating posts
                .navigationBarTitle("Create Post", displayMode: .inline)
            }
            .tabItem {
                Label("Create", systemImage: "plus.circle.fill") // Choose an appropriate system image
            }
        }
        .accentColor(.blue)
        .onAppear {
        }
    }
    
    // Initialize with a callback function
    init(onLogout: @escaping () -> Void) {
        self.onLogout = onLogout
    }
}

