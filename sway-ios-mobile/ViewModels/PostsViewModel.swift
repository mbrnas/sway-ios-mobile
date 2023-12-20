import Foundation
import Combine
import SwiftUI

class PostsViewModel: ObservableObject {
    @Published var posts: [Post] = []
    private var cancellables = Set<AnyCancellable>()

    private var currentPage = 0
    private var totalPages = 1
    private var isLastPage = false
    private var isLoading = false

    func fetchPosts() {
        guard !isLoading, !isLastPage else { return }

        isLoading = true
        let urlString = "http://localhost:8080/api/v1/user/posts/all-posts?pageNumber=\(currentPage)&pageSize=10"
        guard let url = URL(string: urlString) else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        if let token = UserDefaults.standard.string(forKey: "userToken") {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: PostsResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                DispatchQueue.main.async {
                    self?.isLoading = false
                }
                switch completion {
                case .failure(let error):
                    print("Error: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] response in
                DispatchQueue.main.async {
                    self?.posts.append(contentsOf: response.content)
                    self?.currentPage += 1
                    self?.totalPages = response.totalPages
                    self?.isLastPage = response.last
                    print("Current Page: \(self?.currentPage ?? -1), Total Pages: \(self?.totalPages ?? -1), Is Last Page: \(self?.isLastPage ?? true), Is Loading: \(self?.isLoading ?? true)")
                }
            })
            .store(in: &cancellables)
    }

    var canLoadMorePosts: Bool {
        return !isLastPage && !isLoading
    }
}
