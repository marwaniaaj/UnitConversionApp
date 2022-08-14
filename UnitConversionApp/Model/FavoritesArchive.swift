//
//  FavoritesArchive.swift
//  UnitConversionApp
//
//  Created by Marwa Abou Niaaj on 08/08/2022.
//

import Foundation

class FavoritesArchive: NSObject, ObservableObject {
    private let favoritesArchive = FileManager.documentsDirectory.appendingPathComponent("Favorites.archive")

    @Published private(set) var conversions: Conversions
    @Published var favoriteUnitConversions = [UnitConversion]()

    override init() {
        conversions = Conversions()

        super.init()

        loadFavorites()
    }

    private func loadFavorites() {
        if FileManager.default.fileExists(atPath: favoritesArchive.path) {
            do {
                let data = try Data(contentsOf: favoritesArchive)

                guard let unarchived = try NSKeyedUnarchiver.unarchivedObject(ofClass: Conversions.self, from: data) else {
                    conversions = Conversions()
                    return
                }

                conversions = unarchived
                favoriteUnitConversions = conversions.units ?? []
                return
            } catch {
                print("Error unarchiving data: \(error) - \(error.localizedDescription)")
                conversions = Conversions()
                favoriteUnitConversions = []
            }
        }
        conversions = Conversions()
        favoriteUnitConversions = []
    }

    func addToFavorites(_ unit: UnitConversion) {
        conversions.units?.append(unit)
        save()
    }

    func removeFromFavorites(_ unit: UnitConversion) {

        //guard let item = conversions.units?.filter({ $0.id == unit.id }).first else { return }
        guard let index = conversions.units?.firstIndex(of: unit) else { return }

        conversions.units?.remove(at: index)
        save()
    }

    private func save() {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: conversions, requiringSecureCoding: true)
            try data.write(to: favoritesArchive, options: [.atomic, .completeFileProtection])
            print("Data successfully archived")
        } catch {
            print("Error archiving favorite. Error: \(error) -- \(error.localizedDescription)")
        }

        loadFavorites()
    }
}
