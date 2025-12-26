import Combine
import SwiftUI

struct PokemonListResponse: Codable {
    let results: [PokemonListEntry]
}

struct PokemonListEntry: Codable {
    let name: String
    let url: String
}

struct PokemonDetail: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let types: [PokemonTypeSlot]
    let sprites: PokemonSprites

    var primaryType: String {
        types.first?.type.name.capitalized ?? "Unknown"
    }

    var displayName: String {
        name.prefix(1).uppercased() + name.dropFirst()
    }

    static func == (lhs: PokemonDetail, rhs: PokemonDetail) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct PokemonTypeSlot: Codable {
    let slot: Int
    let type: PokemonType
}

struct PokemonType: Codable {
    let name: String
}

struct PokemonSprites: Codable {
    let front_default: String?
}
