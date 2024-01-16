import SwiftUI

struct SettingsView: View {
    @AppStorage("darkModeEnabled") private var darkModeEnabled = false

    private let updateAppearanceMode: (Bool) -> Void = { newValue in
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            windowScene.windows.first?.overrideUserInterfaceStyle = newValue ? .dark : .light
        }
    }

    var body: some View {
        VStack {
            Text("Settings")
                .font(.largeTitle)
                .padding()

            Toggle("Dark Mode", isOn: Binding(
                get: { darkModeEnabled },
                set: { darkModeEnabled = $0; self.updateAppearanceMode($0) }
            ))
            .padding()

            Spacer()

            Text("Made by moncefff on Discord")
                .font(.footnote)
                .foregroundColor(.gray)
                .padding(.bottom, 8)
        }
        .padding()
    }
}
