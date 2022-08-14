//
//  FavoritesView.swift
//  UnitConversionApp
//
//  Created by Marwa Abou Niaaj on 12/08/2022.
//

import SwiftUI

struct FavoritesView: View {
    static let tag: String? = "Favorites"

    @StateObject var viewModel: ViewModel

    let longFormatter: MeasurementFormatter

    var groupedFavorite: [[UnitConversion]] {
        Dictionary(
            grouping: viewModel.favorites,
            by: { $0.unit }
        )
        .sorted(by: {$0.key < $1.key})
        .map { $0.value }
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(groupedFavorite, id: \.self) { groupedConversions in
                    Section {
                        ForEach(groupedConversions) { fav in
                            NavigationLink {
                                UnitConversionView(
                                    unit: viewModel.getUnit(fav.unit),
                                    convertFrom: fav.convertFrom,
                                    convertTo: fav.convertTo,
                                    value: fav.value)
                            } label: {
                                HStack {
                                    Text(longFormatter.string(from: fav.convertFrom).capitalized)

                                    Spacer()

                                    Image(systemName: "arrow.right")
                                        .foregroundColor(Color.accentColor)

                                    Spacer()

                                    Text(longFormatter.string(from: fav.convertTo).capitalized)
                                }
                            }
                        }
                    } header: {
                        Text(headerText(for: groupedConversions))
                            .font(.title3)
                            .textCase(.none)
                            .foregroundColor(Color.accentColor)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, 4)
                    }
                }
            }
            .navigationTitle("Favorites")
            .onAppear {
                viewModel.reloadFavorites()
            }
        }
    }

    func headerText(for groupedConversions: [UnitConversion]) -> String {
        groupedConversions[0].unit
    }

    init() {
        let viewModel = ViewModel()
        _viewModel = StateObject(wrappedValue: viewModel)

        longFormatter = MeasurementFormatter()
        longFormatter.unitOptions = .providedUnit
        longFormatter.unitStyle = .long
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
