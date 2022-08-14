//
//  HomeViewModel.swift
//  UnitConversionApp
//
//  Created by Marwa Abou Niaaj on 12/08/2022.
//

import Foundation

extension HomeView {
    class ViewModel: NSObject, ObservableObject {
        private let unitsJsonFile = "Units.json"

        @Published var units: [Unit]
        @Published var recentUnits = [Unit]()

        override init() {
            let loadedUnits = FileManager.default.decode([Unit].self, from: unitsJsonFile) ?? []
            units = loadedUnits.isEmpty ? Unit.allUnits : loadedUnits

            super.init()
        }

        private func loadUnits() {
            let loadedUnits = FileManager.default.decode([Unit].self, from: unitsJsonFile) ?? []
            units = loadedUnits.isEmpty ? Unit.allUnits : loadedUnits
        }

        func saveUnits() {
            FileManager.default.encode(units, to: unitsJsonFile)
            loadUnits()
        }
    }
}
