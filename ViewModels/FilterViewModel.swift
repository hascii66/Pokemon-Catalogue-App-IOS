import Combine
import Foundation

class FilterViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var selectedSort: SortOption = .idAscending
    @Published var filterType: String? = nil
}
