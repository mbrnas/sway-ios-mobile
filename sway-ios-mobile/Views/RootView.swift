import SwiftUI

struct RootView: View {
    @State private var isLoggedIn: Bool? = nil // nil: hero, false: login, true: dashboard
    
    var body: some View {
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
