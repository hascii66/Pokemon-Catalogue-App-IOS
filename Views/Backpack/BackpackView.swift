import SwiftUI

struct BackpackView: View {
    @EnvironmentObject var viewModel: PokemonViewModel
    @StateObject private var filterVM = FilterViewModel()
    @State private var showFilterSheet = false

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]

    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()

                let rawBackpack = viewModel.rawBackpackPokemon

                if rawBackpack.isEmpty {
                    VStack(spacing: 20) {
                        Image(systemName: "backpack")
                            .font(.system(size: 60))
                            .foregroundColor(.gray)
                        Text("Your backpack is empty!")
                            .font(.title2)
                            .fontWeight(.semibold)
                        Text("Go to the Catalogue to add Pokémon.")
                            .foregroundColor(.secondary)
                    }
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(
                                viewModel.processList(
                                    source: rawBackpack,
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
            .navigationTitle("My Backpack")
            .searchable(text: $filterVM.searchText, prompt: "Search In Backpack")
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
