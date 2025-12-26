import Combine
import Foundation

@MainActor
class PokemonViewModel: ObservableObject {
    @Published var allPokemon: [PokemonDetail] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    @Published var dataRefreshID = UUID()
    
    private let service = PokeAPIService.shared
    private let backpack = BackpackManager.shared
    
    var availableTypes: [String] {
        let types = Set(allPokemon.flatMap { $0.types.map { $0.type.name.capitalized } })
        return types.sorted()
    }
    
    init() {
        loadPokemon()
    }
    
    func loadPokemon() {
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                let fetched = try await service.fetchGenPokemon()
                self.allPokemon = fetched
                self.isLoading = false
            } catch {
                self.errorMessage = "Failed to load Pokémon: \(error.localizedDescription)"
                self.isLoading = false
            }
        }
    }
    
    func processList(source: [PokemonDetail], using filterVM: FilterViewModel) -> [PokemonDetail] {
        var result = source
        
        if !filterVM.searchText.isEmpty {
            result = result.filter { $0.name.lowercased().contains(filterVM.searchText.lowercased()) }
        }
        
        if let type = filterVM.filterType {
            result = result.filter { pokemon in
                pokemon.types.contains(where: { $0.type.name.capitalized == type })
            }
        }
        
        switch filterVM.selectedSort {
        case .idAscending: result.sort { $0.id < $1.id }
        case .idDescending: result.sort { $0.id > $1.id }
        case .nameAZ: result.sort { $0.name < $1.name }
        case .nameZA: result.sort { $0.name > $1.name }
        }
        
        return result
    }
    
    var rawBackpackPokemon: [PokemonDetail] {
        return allPokemon.filter {
            backpack.getData(for: $0.id).isInBackpack
        }
    }
    
    func toggleBackpack(for pokemon: PokemonDetail) {
        backpack.update(id: pokemon.id) { $0.isInBackpack.toggle() }
        dataRefreshID = UUID()
    }
    
    func toggleFavorite(for pokemon: PokemonDetail) {
        backpack.update(id: pokemon.id) { $0.isFavorite.toggle() }
        dataRefreshID = UUID()
    }
    
    func setRating(for pokemon: PokemonDetail, rating: Int) {
        backpack.update(id: pokemon.id) { $0.rating = rating }
        dataRefreshID = UUID()
    }
    
    func getUserData(for pokemon: PokemonDetail) -> UserPokemonData {
        return backpack.getData(for: pokemon.id)
    }
}
