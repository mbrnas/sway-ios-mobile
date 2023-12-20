import Foundation
import Combine

class LoginViewModel: ObservableObject {
    @Published var username = ""
    @Published var password = ""
    var loginAction: () -> Void

    private var cancellables = Set<AnyCancellable>()

    init(loginAction: @escaping () -> Void) {
        self.loginAction = loginAction
    }

    func signIn() {
        print("Sign in started")
        guard let url = URL(string: "http://localhost:8080/api/v1/auth/signin") else { return }

        let request = SignInRequest(username: username, password: password)
        guard let requestData = try? JSONEncoder().encode(request) else { return }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = requestData

        URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map(\.data)
            .decode(type: SignInResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] signInResponse in
                // Storing the token and refresh token
                UserDefaults.standard.set(signInResponse.token, forKey: "userToken")
                UserDefaults.standard.set(signInResponse.refreshToken, forKey: "userRefreshToken")

                self?.loginAction() 
            })
            .store(in: &cancellables)
    }
}
