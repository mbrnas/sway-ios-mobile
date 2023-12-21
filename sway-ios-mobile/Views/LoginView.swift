import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel: LoginViewModel
    @State private var isAnimating = false
    @State private var isNavigatingToSignUp = false

    init(loginAction: @escaping () -> Void) {
        _viewModel = StateObject(wrappedValue: LoginViewModel(loginAction: loginAction))
    }

    var body: some View {
        VStack {
            Spacer()

            // App Title
            Text("Sway")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color(hex: "00A9FF"))
                .scaleEffect(isAnimating ? 1.1 : 1.0)
                .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true), value: isAnimating)
                .padding(.bottom, 50)

            // Username and Password Fields
            VStack(spacing: 15) {
                TextField("Username", text: $viewModel.username)
                    .padding()
                    .background(Color(hex: "F0F0F0"))
                    .cornerRadius(5)
                    .padding(.horizontal, 20)
                    .offset(x: isAnimating ? 0 : -UIScreen.main.bounds.width)

                SecureField("Password", text: $viewModel.password)
                    .padding()
                    .background(Color(hex: "F0F0F0"))
                    .cornerRadius(5)
                    .padding(.horizontal, 20)
                    .offset(x: isAnimating ? 0 : UIScreen.main.bounds.width)
            }
            .padding(.bottom, 20)
            .animation(.easeOut(duration: 0.8), value: isAnimating)

            // Login Button
            Button(action: viewModel.signIn) {
                Text("Log In")
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(hex: "00A9FF"))
                    .cornerRadius(10)
                    .scaleEffect(isAnimating ? 1.05 : 1.0)
                    .animation(.easeInOut(duration: 0.6).repeatForever(autoreverses: true), value: isAnimating)
            }
            .padding(.horizontal, 20)

            // Sign Up Link
            HStack {
                Text("Don't have an account? ")
                    .foregroundColor(.gray)
                
                Button(action: { isNavigatingToSignUp = true }) {
                    Text("Sign up!")
                        .foregroundColor(Color(hex: "00A9FF"))
                }
            }
            .padding(.top, 20)

            Spacer()

            // Navigation to SignupView
            NavigationLink(destination: SignUpView(), isActive: $isNavigatingToSignUp) {
                EmptyView()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .padding(.horizontal, 30)
        .onAppear {
            self.isAnimating = true
        }
    }
}

// Helper Extension for Color
extension Color {
    init(hexColorString: String) {
        let scanner = Scanner(string: hexColorString)
        _ = scanner.scanString("#")
        
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)

        let r = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let g = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let b = Double(rgbValue & 0x0000FF) / 255.0

        self.init(red: r, green: g, blue: b)
    }
}

// Preview
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(loginAction: {})
    }
}
