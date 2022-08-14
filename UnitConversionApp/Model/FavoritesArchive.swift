//
//  FavoritesArchive.swift
//  UnitConversionApp
//
//  Created by Marwa Abou Niaaj on 12/08/2022.
//

import Foundation

/// A class responsible for managing favorite unit conversions.
/// Including archiving and writing data into document directory,
/// Unarchiving and loading data into conversions array.
final class FavoritesArchive: NSObject, ObservableObject {
    private let favoritesArchiveUrl = FileManager.documentsDirectory.appendingPathComponent("Favorites.archive")

    @Published private var conversions = Conversions()
    @Published private(set) var favoriteUnitConversions = [UnitConversion]()

    override init() {
        super.init()
        loadFavorites()
    }

    private func loadFavorites() {
        guard FileManager.default.fileExists(atPath: favoritesArchiveUrl.path) else {
            conversions = Conversions()
            favoriteUnitConversions = []
            return
        }

        do {
            let data = try Data(contentsOf: favoritesArchiveUrl)

            // Decodes a previously-archived object graph, and returns the root object as the specified type.
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

    func addToFavorites(_ unit: UnitConversion) {
        conversions.units?.append(unit)
        archiveFavorites()
    }

    func removeFromFavorites(_ unit: UnitConversion) {
        guard let index = conversions.units?.firstIndex(of: unit) else { return }
        conversions.units?.remove(at: index)
        archiveFavorites()
    }

    private func archiveFavorites() {
        do {
            // Encodes an object graph with the given root object into a data representation.
            let data = try NSKeyedArchiver.archivedData(withRootObject: conversions, requiringSecureCoding: true)
            try data.write(to: favoritesArchiveUrl, options: [.atomic, .completeFileProtection])
            print("Data successfully archived")
        } catch {
            print("Error archiving favorite. Error: \(error) -- \(error.localizedDescription)")
        }

        loadFavorites()
    }
}
