import SwiftUI

struct PokemonTypeTheme {
    static func color(for type: String) -> Color {
        switch type.lowercased() {
        case "fire": return .orange
        case "water": return .blue
        case "grass": return .green
        case "electric": return .yellow
        case "psychic": return .purple
        case "poison": return .purple
        case "bug": return .green
        case "ground": return .brown
        case "rock": return .gray
        case "fighting": return .red
        case "ice": return .cyan
        case "dragon": return .indigo
        case "ghost": return .purple
        case "fairy": return .pink
        case "normal": return .gray
        case "flying": return .blue.opacity(0.5)
        default: return .gray
        }
    }
}
