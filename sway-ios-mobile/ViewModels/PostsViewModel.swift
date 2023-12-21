import Foundation
import Combine
import SwiftUI

class PostsViewModel: ObservableObject {
    @Published var posts: [Post] = []      // All fetched posts
    @Published var displayedPosts: [Post] = [] // Posts to display in the UI

    private var cancellables = Set<AnyCancellable>()
    private var currentLoadIndex = 0
    private let loadIncrement = 5           // Number of posts to load each time

    func fetchPosts() {
        let urlString = "http://localhost:8080/api/v1/user/posts/all-posts"
        guard let url = URL(string: urlString) else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        if let token = UserDefaults.standard.string(forKey: "userToken") {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: [Post].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    print("Error: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] fetchedPosts in
                self?.posts = fetchedPosts
                self?.loadMorePosts()  // Load initial set of posts
            })
            .store(in: &cancellables)
    }

    func loadMorePosts() {
        let nextIndex = currentLoadIndex + loadIncrement
        let newPosts = posts[currentLoadIndex..<min(nextIndex, posts.count)]
        displayedPosts.append(contentsOf: newPosts)
        currentLoadIndex = nextIndex
    }

    var canLoadMorePosts: Bool {
        currentLoadIndex < posts.count
    }
}
