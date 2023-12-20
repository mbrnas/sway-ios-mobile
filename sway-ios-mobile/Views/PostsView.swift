import Foundation
import SwiftUI

struct PostsView: View {
    @ObservedObject var viewModel: PostsViewModel // Use an observed object passed from the parent view

    var logoutAction: () -> Void

    let customColor = Color(hex: "00A9FF")

    var body: some View {
           NavigationView {
               ScrollView {
                   LazyVStack(spacing: 15) {
                       ForEach(viewModel.posts, id: \.id) { post in
                           PostCardView(post: post, customColor: customColor)
                       }

                       if viewModel.canLoadMorePosts {
                           Button("Load More Posts") {
                               viewModel.fetchPosts()
                           }
                           .padding()
                           .background(Color(hex: "00A9FF"))
                           .foregroundColor(.white)
                           .cornerRadius(8)
                       }
                          
                       
                   }
                   .padding()
               }
            .navigationTitle("Posts")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button(action: logoutAction) {
                Image(systemName: "power")
                    .imageScale(.large)
                    .foregroundColor(customColor)
            })
        }
        .onAppear {
            if viewModel.posts.isEmpty {
                            viewModel.fetchPosts()
                        }
        }
    }
}

struct PostCardView: View {
    var post: Post
    let customColor: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Circle()
                    .fill(customColor)
                    .frame(width: 50, height: 50)
                    .overlay(Text("U").font(.title).foregroundColor(.white))

                VStack(alignment: .leading) {
                    Text(post.user.username)
                        .font(.headline)
                        .foregroundColor(customColor)
                    Text(post.datePosted)
                        .font(.caption)
                        .foregroundColor(.gray)
                }

                Spacer()

                Button(action: { /* More actions */ }) {
                    Image(systemName: "ellipsis")
                        .foregroundColor(.gray)
                }
            }

            Text(post.title)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(customColor)
            
            Text(post.content)
                .font(.body)
                .lineLimit(4)
                .padding(.top, 2)

            HStack {
                Button(action: { /* Like action */ }) {
                    Label("\(post.likes)", systemImage: "heart.fill")
                        .foregroundColor(customColor)
                }
                .buttonStyle(BorderlessButtonStyle())

                Spacer()

                // Additional actions can be added here
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

// Existing Color extension for hex color support
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
