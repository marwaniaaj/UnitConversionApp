//
//  FavoritesViewModel.swift
//  UnitConversionApp
//
//  Created by Marwa Abou Niaaj on 12/08/2022.
//

import CoreData
import Foundation

extension FavoritesView {
    class ViewModel: NSObject, ObservableObject {
        let archive = AppSettings.shared.favoritesArchive

        @Published var favorites = [UnitConversion]()

        override init() {
            favorites = archive.favoriteUnitConversions
            super.init()
        }

        func getUnit(_ name: String) -> Unit {
            Unit.allUnits.filter { $0.name == name}.first!
        }

        func reloadFavorites() {
            favorites = archive.favoriteUnitConversions
        }
    }
}
