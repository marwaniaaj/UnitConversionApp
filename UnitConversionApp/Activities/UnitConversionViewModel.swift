//
//  UnitConversionViewModel.swift
//  UnitConversionApp
//
//  Created by Marwa Abou Niaaj on 12/08/2022.
//

import Foundation

extension UnitConversionView {
    class ViewModel: NSObject, ObservableObject {
        let archive = AppSettings.shared.favoritesArchive
        let unit: Unit

        @Published var isFavorite = false
        @Published var unitTypes = [Dimension]()
        @Published var inputValue = 10.0
        @Published var inputUnit: Dimension = UnitLength.kilometers
        @Published var outputUnit: Dimension = UnitLength.kilometers

        init(unit: Unit) {
            self.unit = unit

            super.init()
            
            self.unitTypes = Unit.unitTypes.filter({ $0.key == unit.name }).first?.value ?? [Dimension]()
            self.inputUnit = self.unitTypes[0]
            self.outputUnit = self.unitTypes[1]
        }

        init(unit: Unit, convertFrom: Dimension, convertTo: Dimension, value: Double) {
            self.unit = unit
            self.inputUnit = convertFrom
            self.outputUnit = convertTo
            self.inputValue = value

            self.unitTypes = Unit.unitTypes.filter({ $0.key == unit.name }).first?.value ?? [Dimension]()
        }

        func checkFavorite() {
            if let _ = archive.favoriteUnitConversions.filter ({
                $0.convertFrom == inputUnit && $0.convertTo == outputUnit
            }).first {
                isFavorite = true
                return
            }
            isFavorite = false
        }

        func toggleFavorite() {
            if isFavorite {
                addToFavorites()
            } else {
                removeFromFavorites()
            }
        }

        private func addToFavorites() {
            let fav = UnitConversion(convertFrom: inputUnit, convertTo: outputUnit, unit: unit.name, value: inputValue)
            archive.addToFavorites(fav)
        }

        private func removeFromFavorites() {
            guard let fav = archive.favoriteUnitConversions.filter({
                $0.convertFrom == inputUnit && $0.convertTo == outputUnit
            }).first else { return }
            archive.removeFromFavorites(fav)
        }
    }
}
