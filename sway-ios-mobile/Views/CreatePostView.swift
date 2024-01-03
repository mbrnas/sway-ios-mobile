import SwiftUI

struct CreatePostView: View {
    @State private var postTitle: String = ""
    @State private var postContent: String = ""

    var body: some View {
        NavigationView {
            VStack {
                CardView {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Create a New Post")
                            .font(.headline)

                        TextField("Post Title", text: $postTitle)
                            .textFieldStyle(RoundedBorderTextFieldStyle())

                        TextEditor(text: $postContent)
                            .frame(height: 200)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 1)
                            )

                        Button(action: createPost) {
                            Text("Create")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                        .padding(.top, 10)
                    }
                    .padding()
                }
                .padding()
            }
            .navigationBarTitle("New Post", displayMode: .inline)
        }
    }

    private func createPost() {
        // Implement the post creation logic here
        print("Post Title: \(postTitle), Post Content: \(postContent)")
    }
}

struct CardView<Content: View>: View {
    let content: Content
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(Color.white)
                .shadow(radius: 10)
            content
        }
    }
}
