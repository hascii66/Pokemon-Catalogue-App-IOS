import SwiftUI

struct CatalogueView: View {
    @EnvironmentObject var viewModel: PokemonViewModel
    @StateObject private var filterVM = FilterViewModel()
    @State private var showFilterSheet = false
    
    @State private var sheetHeight: CGFloat = 300

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]

    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()

                if viewModel.isLoading {
                    ProgressView("Catching 'em all...")
                        .scaleEffect(1.5)
                } else if let error = viewModel.errorMessage {
                    VStack {
                        Image(systemName: "exclamationmark.triangle")
                            .font(.largeTitle)
                            .foregroundColor(.orange)
                        Text(error).multilineTextAlignment(.center)
                        Button("Retry") { viewModel.loadPokemon() }
                            .buttonStyle(.bordered)
                    }
                    .padding()
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(
                                viewModel.processList(
                                    source: viewModel.allPokemon,
                                    using: filterVM
                                )
                            ) { pokemon in
                                PokemonCardView(pokemon: pokemon)
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Pokédex Gen 1")
            .searchable(text: $filterVM.searchText, prompt: "Search Pokémon")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showFilterSheet.toggle() }) {
                        Image(systemName: "slider.horizontal.3")
                    }
                }
            }
            .sheet(isPresented: $showFilterSheet) {
                FilterSortView(filterVM: filterVM)
                    .presentationDetents([.height(350)])
            }
        }
    }
}
