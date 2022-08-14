//
//  UnitConversionViewModel.swift
//  Unitify
//
//  Created by Marwa Abou Niaaj on 08/08/2022.
//

import Foundation

extension UnitConversionView {
    class ViewModel: NSObject, ObservableObject {
        let archive = AppSettings.shared.favoritesArchive

        let unit: UnitObject

        @Published var isFavorite = false
        @Published var unitTypes = [Dimension]()
        @Published var inputValue = 1.0
        @Published var inputUnit: Dimension = UnitLength.kilometers
        @Published var outputUnit: Dimension = UnitLength.kilometers

        init(unit: UnitObject) {
            self.unit = unit

            super.init()
            
            self.unitTypes = UnitObject.unitTypes.filter({ $0.key == unit.name }).first?.value ?? [Dimension]()
            self.inputUnit = self.unitTypes[0]
            self.outputUnit = self.unitTypes[1]
        }

//        init(favorite: Favorites) {
//            self.unit = UnitObject.allUnits.filter { $0.name == favorite.unitString }.first!
//            super.init()
//
//            self.isFavorite = true
//            self.inputUnit = favorite.fromUnit
//            self.outputUnit = favorite.toUnit
//            self.inputValue = favorite.value
//            self.unitTypes = UnitObject.unitTypes.filter({ $0.key == unit.name }).first?.value ?? []
//        }

        init(unit: UnitObject, convertFrom: Dimension, convertTo: Dimension, value: Double) {
            self.unit = unit
            self.inputUnit = convertFrom
            self.outputUnit = convertTo
            self.inputValue = value

            self.unitTypes = UnitObject.unitTypes.filter({ $0.key == unit.name }).first?.value ?? [Dimension]()
        }

        func updateUnit() {
            unit.lastModified = Date()
        }

        func checkFavorite() {
            if let _ = archive.conversions.units?.filter ({
                $0.convertFrom == inputUnit && $0.convertTo == outputUnit
            }).first {
                isFavorite = true
                return
            }
            isFavorite = false
        }

        func toggleFavorite() {
//            if isFavorite {
//                addToFavorites()
//            } else {
//                removeFromFavorites()
//            }
        }

        private func addToFavorites() {
//            let fav = UnitConversion(convertFrom: inputUnit, convertTo: outputUnit, unit: unit.name, value: inputValue)
//            archive.addToFavorites(fav)
        }

        private func removeFromFavorites() {
//            guard let fav = archive.favoriteUnitConversions.filter({
//                $0.convertFrom == inputUnit && $0.convertTo == outputUnit
//            }).first else { return }
//            archive.removeFromFavorites(fav)
        }
    }
}
