//
//  FavoritesView.swift
//  Unitify
//
//  Created by Marwa Abou Niaaj on 08/08/2022.
//

import SwiftUI

struct FavoritesView: View {
    static let tag: String? = "Favorites"
    @Environment(\.layoutDirection) var layoutDirection
    @ObservedObject private var settings = AppSettings.shared
    @StateObject var viewModel: ViewModel

    let longFormatter: MeasurementFormatter

//    var groupedFavorite: [[Favorites]] {
//        Dictionary(grouping: viewModel.favorites, by: { $0.unitString }).sorted(by: {$0.key < $1.key}).map { $0.value }
//    }

    var columns: [GridItem] {
        [GridItem(.fixed(100))]
    }
    
    var body: some View {
        NavigationView {
            List {
//                ForEach(groupedFavorite, id: \.self) { groupedConversions in
//                    Section {
//                        ForEach(groupedConversions) { fav in
//                            NavigationLink {
//                                UnitConversionView(
//                                    unit: viewModel.getUnit(fav.unitString),
//                                    convertFrom: fav.fromUnit,
//                                    convertTo: fav.toUnit,
//                                    value: fav.value)
//                            } label: {
//                                HStack {
//                                    Text(longFormatter.string(from: fav.fromUnit).capitalized)
//
//                                    Spacer()
//
//                                    Image(systemName: layoutDirection == .leftToRight ? "arrow.right" : "arrow.left")
//                                        .foregroundColor(settings.theme.primaryColor)
//                                        .accessibilityHidden(true)
//
//                                    Spacer()
//
//                                    Text(longFormatter.string(from: fav.toUnit).capitalized)
//
//                                    Spacer()
//                                }
//                                .accessibilityElement(children: .ignore)
//                                .accessibilityLabel(
//                                    Text("\(longFormatter.string(from: fav.fromUnit)) to \(longFormatter.string(from: fav.toUnit))")
//                                )
//                            }
//                        }
//                    } header: {
//                        UnitSectionHeader(title: headerText(for: groupedConversions))
//                    }
//                }
            }
            .navigationTitle("Favorites")
            .onAppear {
                viewModel.reloadFavorites()
            }

            FavoriteEmptyView()
        }
    }

//    func headerText(for groupedConversions: [Favorites]) -> String {
//        groupedConversions[0].unitString
//    }

    init(dataController: DataController) {
        let viewModel = ViewModel(dataController: dataController)
        _viewModel = StateObject(wrappedValue: viewModel)

        longFormatter = MeasurementFormatter()
        longFormatter.unitOptions = .providedUnit
        longFormatter.unitStyle = .long
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var dataController = DataController.preview

    static var previews: some View {
        FavoritesView(dataController: dataController)
    }
}
