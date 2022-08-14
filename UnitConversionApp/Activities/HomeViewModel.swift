//
//  HomeViewModel.swift
//  Unitify
//
//  Created by Marwa Abou Niaaj on 09/08/2022.
//

import Foundation

extension HomeView {
    class ViewModel: NSObject, ObservableObject {
        private let unitsJsonFile = "Units.json"

        let unitifyManager: UnitifyManager

//        @Published var units: [UnitObject]
//        @Published var recentUnits = [UnitObject]()
//        @Published var conversions: [UnitCategoryObject]

        @Published var units: [Unit]
        @Published var recentUnits = [Unit]()

//        override init() {
//            let loadedUnits = FileManager.default.decode([UnitObject].self, from: unitsJsonFile) ?? []
//            units = loadedUnits.isEmpty ? UnitObject.allUnits : loadedUnits
//            conversions = UnitCategoryObject.allUnitCategories
//
//            super.init()
//
//            recentUnits = getRecentUnits()
//        }

        init(unitifyManager: UnitifyManager) {
            self.unitifyManager = unitifyManager
            self.units = unitifyManager.units
            self.recentUnits = Array(unitifyManager.recentUnits)
        }

        private func loadUnits() {
//            let loadedUnits = FileManager.default.decode([UnitObject].self, from: unitsJsonFile) ?? []
//            units = loadedUnits.isEmpty ? UnitObject.allUnits : loadedUnits
//            recentUnits = getRecentUnits()
        }

//        private func getRecentUnits() -> [UnitObject] {
//            Array(
//                units.filter {
//                    $0.lastModified != nil
//                }
//                .sorted(by: {
//                    $0.lastModified ?? Date()  > $1.lastModified ?? Date()
//                })
//                .prefix(7)
//            )
//        }

        func saveUnits() {
//            FileManager.default.encode(units, to: unitsJsonFile)
//            loadUnits()
        }

        func updateUnit(_ unit: UnitObject) {
//            unit.lastModified = Date()
        }

//        func getUnits(in category: String) -> [UnitObject] {
//            let filtered = units.filter { $0.category == category }
//            if !filtered.isEmpty {
//                return filtered
//            }
//            return units
//        }
    }
}
