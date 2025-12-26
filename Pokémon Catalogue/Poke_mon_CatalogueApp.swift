import SwiftUI

@main
struct Poke_mon_CatalogueApp: App {
    @StateObject private var viewModel = PokemonViewModel()
    @State private var showSplash = true

    var body: some Scene {
        WindowGroup {
            ZStack {
                if showSplash {
                    SplashScreenView(isActive: $showSplash)
                } else {
                    MainTabView()
                        .environmentObject(viewModel)
                        .transition(.opacity)
                }
            }
            .animation(.easeInOut(duration: 0.5), value: showSplash)
        }
    }
}
