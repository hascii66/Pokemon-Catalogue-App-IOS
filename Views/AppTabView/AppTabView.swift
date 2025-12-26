import SwiftUI

struct AppTabView: View {
    @State private var selectedTab: Tab = .catalogue

    var body: some View {
        VStack(spacing: 0) {
            Group {
                switch selectedTab {
                case .catalogue:
                    CatalogueView()
                case .backpack:
                    BackpackView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            HStack(spacing: 0) {
                tabButton(
                    title: "Catalogue",
                    icon: "list.bullet",
                    tab: .catalogue
                )

                tabButton(
                    title: "Backpack",
                    icon: "backpack.fill",
                    tab: .backpack
                )
            }
            .frame(height: 56)
            .background(Color(.systemBackground))
        }
    }

    private func tabButton(title: String, icon: String, tab: Tab) -> some View {
        Button {
            selectedTab = tab
        } label: {
            VStack(spacing: 4) {
                Image(systemName: icon)
                Text(title)
                    .font(.caption)
            }
            .frame(maxWidth: .infinity)
            .foregroundColor(selectedTab == tab ? .red : .gray)
        }
    }
}

enum Tab {
    case catalogue
    case backpack
}
