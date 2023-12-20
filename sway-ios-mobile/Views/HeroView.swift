import SwiftUI

struct HeroView: View {
    var onContinue: () -> Void

    let purpleColor = Color(hex: "7B66FF")

    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            Text("Welcome to Your Blogging Journey")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(purpleColor)
                .multilineTextAlignment(.center)
                .padding()

            Text("Discover, create, and share your thoughts with the world.")
                .foregroundColor(purpleColor)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Button(action: onContinue) {
                Text("Get Started")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(purpleColor)
                    .cornerRadius(10)
            }
            .padding()

            Spacer()
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
