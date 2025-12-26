import Foundation

class BackpackManager {
    static let shared = BackpackManager()
    private let key = "user_pokemon_data"

    private(set) var data: [Int: UserPokemonData] = [:]

    private init() {
        loadData()
    }

    func getData(for id: Int) -> UserPokemonData {
        return data[id] ?? UserPokemonData()
    }

    func update(id: Int, mutation: (inout UserPokemonData) -> Void) {
        var current = getData(for: id)
        mutation(&current)
        data[id] = current
        saveData()
    }

    private func saveData() {
        if let encoded = try? JSONEncoder().encode(data) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }

    private func loadData() {
        if let savedData = UserDefaults.standard.data(forKey: key),
            let decoded = try? JSONDecoder().decode(
                [Int: UserPokemonData].self,
                from: savedData
            )
        {
            self.data = decoded
        }
    }
}
