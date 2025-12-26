import SwiftUI

struct PokemonCardView: View {
    @EnvironmentObject var viewModel: PokemonViewModel
    let pokemon: PokemonDetail
    @State private var isExpanded = false

    private var backgrounColor: Color {
        PokemonTypeTheme.color(for: pokemon.primaryType)
    }

    var body: some View {
        let userData = viewModel.getUserData(for: pokemon)

        VStack(spacing: 12) {
            HStack {
                Spacer()
                Button(action: { viewModel.toggleFavorite(for: pokemon) }) {
                    Image(
                        systemName: userData.isFavorite ? "heart.fill" : "heart"
                    )
                    .foregroundColor(
                        userData.isFavorite ? .red : .gray.opacity(0.5)
                    )
                    .font(.title3)
                }
            }

            if let urlString = pokemon.sprites.front_default {
                RemoteImageView(urlString: urlString)
                    .frame(width: 150, height: 150)
            } else {
                Image(systemName: "questionmark.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                    .foregroundColor(.white.opacity(0.5))
            }

            VStack(spacing: 4) {
                Text(pokemon.displayName)
                    .font(.headline)
                    .fontWeight(.bold)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
                    .foregroundColor(.black)

                HStack(spacing: 4) {
                    ForEach(pokemon.types, id: \.slot) { typeSlot in
                        TypeBadge(typeName: typeSlot.type.name.capitalized)
                    }
                }
            }

            if isExpanded {
                Divider()
                    .background(Color.black.opacity(0.1))
                    .transition(.opacity)

                StarRatingView(rating: userData.rating) { newRating in
                    viewModel.setRating(for: pokemon, rating: newRating)
                }
                .font(.caption2)
                .transition(.opacity)

                Button(action: { viewModel.toggleBackpack(for: pokemon) }) {
                    Text(userData.isInBackpack ? "Remove" : "Add")
                        .font(.caption)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                        .background(
                            userData.isInBackpack
                                ? Color.black.opacity(0.6)
                                : Color.blue.opacity(0.6)
                        )
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .transition(.opacity)
            } else {
                Image(systemName: "chevron.down")
                    .font(.caption)
                    .foregroundColor(.black.opacity(0.3))
                    .padding(.top, 4)
            }
        }
        .padding(12)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [
                    backgrounColor.opacity(0.5),
                    .white,
                ]),
                startPoint: UnitPoint(x: 0.5, y: 0.3),
                endPoint: UnitPoint(x: 0.5, y: 0.7)
            )
        )
        .cornerRadius(16)
        .shadow(color: backgrounColor.opacity(0.3), radius: 5, x: 0, y: 2)
        .onTapGesture {
            withAnimation(.spring()) {
                isExpanded.toggle()
            }
        }
    }
}
