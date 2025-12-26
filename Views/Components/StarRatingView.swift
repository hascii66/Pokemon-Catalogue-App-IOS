import SwiftUI

struct StarRatingView: View {
    var rating: Int
    var onTap: (Int) -> Void

    var body: some View {
        HStack(spacing: 4) {
            ForEach(1...5, id: \.self) { index in
                Image(systemName: index <= rating ? "star.fill" : "star")
                    .foregroundColor(.yellow)
                    .font(.body)
                    .onTapGesture {
                        onTap(index)
                    }
            }
        }
    }
}
