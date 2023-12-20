import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel: LoginViewModel

    init(loginAction: @escaping () -> Void) {
        _viewModel = StateObject(wrappedValue: LoginViewModel(loginAction: loginAction))
    }

    var body: some View {
        VStack {
            Spacer() // Push content down

            Text("Code Chronicles")
                .font(.largeTitle)
                .foregroundColor(.blue)
                .padding(.bottom, 30)

            VStack(spacing: 20) {
                TextField("Username", text: $viewModel.username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 20)

                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 20)
            }
            .padding(.vertical, 20)

            Button(action: viewModel.signIn) {
                Text("Log In")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.horizontal, 20)

            Spacer() // Push content up
        }
        .padding(.horizontal, 30)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(loginAction: {})
    }
}
