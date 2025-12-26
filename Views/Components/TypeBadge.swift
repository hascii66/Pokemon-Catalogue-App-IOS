import SwiftUI

struct TypeBadge: View {
    let typeName: String

    var typeColor: Color {
        PokemonTypeTheme.color(for: typeName)
    }

    var body: some View {
        Text(typeName)
            .font(.caption2)
            .fontWeight(.bold)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(typeColor.opacity(0.2))
            .foregroundColor(typeColor)
            .cornerRadius(4)
    }
}
