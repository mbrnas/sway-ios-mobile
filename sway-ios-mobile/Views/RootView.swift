import SwiftUI

struct RootView: View {
    @State private var isLoggedIn: Bool? = nil

    var body: some View {
        NavigationView {
            VStack {
                switch isLoggedIn {
                case .none:
                    HeroView(onContinue: { self.isLoggedIn = false })
                case .some(true):
                    MainAppView(onLogout: { self.isLoggedIn = false })
                case .some(false):
                    LoginView(loginAction: { self.isLoggedIn = true })
                }
            }
        }
    }
}
