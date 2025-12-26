import Foundation

enum SortOption: String, CaseIterable, Identifiable {
    case idAscending = "# (1-151)"
    case idDescending = "# (151-1)"
    case nameAZ = "Name (A-Z)"
    case nameZA = "Name (Z-A)"

    var id: String { self.rawValue }
}

class PokeAPIService {
    static let shared = PokeAPIService()
    private let baseURL = "https://pokeapi.co/api/v2/pokemon"
    private let cacheFileName = "pokemon_cache.json"
    
    private init() {}
    
    func fetchGenPokemon() async throws -> [PokemonDetail] {
        guard let url = URL(string: "\(baseURL)?limit=151") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let listResponse = try JSONDecoder().decode(PokemonListResponse.self, from: data)

        let details = try await withThrowingTaskGroup(of: PokemonDetail?.self) { group in
            for entry in listResponse.results {
                group.addTask {
                    guard let detailURL = URL(string: entry.url) else { return nil }
                    let (detailData, _) = try await URLSession.shared.data(from: detailURL)
                    return try JSONDecoder().decode(PokemonDetail.self, from: detailData)
                }
            }
            
            var results: [PokemonDetail] = []
            for try await detail in group {
                if let detail = detail {
                    results.append(detail)
                }
            }
            return results.sorted { $0.id < $1.id }
        }
        
        saveToCache(data: details)
        return details
    }
    
    private var cacheURL: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent(cacheFileName)
    }
    
    func saveToCache(data: [PokemonDetail]) {
        do {
            let encoded = try JSONEncoder().encode(data)
            try encoded.write(to: cacheURL)
            print("Saved \(data.count) pokemon to cache.")
        } catch {
            print("Failed to save cache: \(error)")
        }
    }
    
    func loadFromCache() -> [PokemonDetail]? {
        do {
            let data = try Data(contentsOf: cacheURL)
            let decoded = try JSONDecoder().decode([PokemonDetail].self, from: data)
            print("Loaded \(decoded.count) pokemon from cache.")
            return decoded
        } catch {
            print("Cache miss or error: \(error)")
            return nil
        }
    }
}
