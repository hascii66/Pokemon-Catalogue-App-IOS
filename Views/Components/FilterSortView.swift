import SwiftUI

struct FilterSortView: View {
    @ObservedObject var filterVM: FilterViewModel
    @EnvironmentObject var viewModel: PokemonViewModel
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            Form {
                Section("Sort By") {
                    Picker("Sort", selection: $filterVM.selectedSort) {
                        ForEach(SortOption.allCases) { option in
                            Text(option.rawValue).tag(option)
                        }
                    }
                    .pickerStyle(.menu)
                }

                Section("Filter By Type") {
                    Picker("Type", selection: $filterVM.filterType) {
                        Text("All Types").tag(String?.none)
                        ForEach(viewModel.availableTypes, id: \.self) { type in
                            Text(type).tag(String?.some(type))
                        }
                    }
                    .pickerStyle(.menu)
                }

                Section {
                    Button("Reset Filters") {
                        filterVM.selectedSort = .idAscending
                        filterVM.filterType = nil
                        dismiss()
                    }
                    .foregroundColor(.red)
                }
            }
            .navigationTitle("Sort & Filter")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") { dismiss() }
                }
            }
        }
    }
}
