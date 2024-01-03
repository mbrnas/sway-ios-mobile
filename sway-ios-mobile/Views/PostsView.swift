import Foundation
import SwiftUI

import SwiftUI

struct PostsView: View {
    @ObservedObject var viewModel: PostsViewModel
    var logoutAction: () -> Void
    @State private var selectedPost: Post? = nil

    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemBackground).edgesIgnoringSafeArea(.all)

                ScrollView {
                    LazyVStack(spacing: 20) {
                        ForEach(viewModel.displayedPosts, id: \.id) { post in
                            PostCardView(post: post)
                                .frame(width: 360, height: 400)
                                .onTapGesture {
                                    withAnimation {
                                        selectedPost = post
                                    }
                                }
                        }

                        if viewModel.canLoadMorePosts {
                            Button("Load More Posts") {
                                viewModel.loadMorePosts()
                            }
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                        }
                    }
                }
                .blur(radius: selectedPost != nil ? 4 : 0)

                if let selectedPost = selectedPost {
                    PostCardView(post: selectedPost)
                        .frame(width: UIScreen.main.bounds.width * 0.85, height: 440)
                        .onTapGesture {
                            withAnimation {
                                self.selectedPost = nil
                            }
                        }
                        .transition(.scale)
                        .zIndex(1)
                }
            }
            .navigationBarTitle("Posts", displayMode: .inline)
                    .navigationBarItems(trailing: Button(action: logoutAction) {
                        Image(systemName: "power").foregroundColor(.blue)
                    })
        }
        .navigationViewStyle(StackNavigationViewStyle()) // Add this line
    }
}









struct PostCardView: View {
    var post: Post
    var isSelected: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // User Info
            HStack {
                Circle()
                    .fill(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .top, endPoint: .bottom))
                    .frame(width: 50, height: 50)
                    .overlay(Text("U").foregroundColor(.white))

                VStack(alignment: .leading, spacing: 4) {
                    Text(post.user.username).font(.headline)
                    Text(post.datePosted).font(.caption).foregroundColor(.gray)
                }
                Spacer()
            }

            // Post Title
            Text(post.title)
                .font(.title2)
                .fontWeight(.bold)
                .lineLimit(2)
                .truncationMode(.tail)

            // Post Content
            Text(post.content)
                .font(.body)
                .lineLimit(4)
                .truncationMode(.tail)
                .padding(.vertical, 2)

            // Like Button and Count
            HStack {
                Button(action: { /* Like action */ }) {
                    Label("\(post.likes)", systemImage: "heart.fill")
                        .foregroundColor(.red)
                }
                Spacer()
            }
        }
        .padding()
        .padding()
                .frame(width: 360, height: 400, alignment: .topLeading)
                .background(Color.white)
                .cornerRadius(15)
                .shadow(color: .gray, radius: 10, x: 0, y: 10)
    }
}





extension Color {
    init(hexString: String) {
        let scanner = Scanner(string: hexString)
        _ = scanner.scanString("#")
        
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)

        let r = Double((rgbValue & 0xff0000) >> 16) / 255.0
        let g = Double((rgbValue & 0xff00) >> 8) / 255.0
        let b = Double(rgbValue & 0xff) / 255.0

        self.init(red: r, green: g, blue: b)
    }
}
