//
//  FavoritesViewModel.swift
//  Unitify
//
//  Created by Marwa Abou Niaaj on 08/08/2022.
//

import CoreData
import Foundation

extension FavoritesView {
    class ViewModel: NSObject, ObservableObject, NSFetchedResultsControllerDelegate {
        //let archive = AppSettings.shared.favoritesArchive

        private let favoritesController: NSFetchedResultsController<Favorites>
        @Published var favorites = [Favorites]()

        var dataController: DataController

        init(dataController: DataController) {
            //favorites = archive.favoriteUnitConversions
            self.dataController = DataController()

            // Construct a fetch request to show all favorite unit conversions.
            let favoritesRequest = Favorites.fetchRequest()
            favoritesRequest.predicate = nil
            favoritesRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Favorites.id, ascending: true)]

            favoritesController = NSFetchedResultsController(
                fetchRequest: favoritesRequest,
                managedObjectContext: dataController.container.viewContext,
                sectionNameKeyPath: nil,
                cacheName: nil
            )

            super.init()

            favoritesController.delegate = self
            performFetch()
        }

        private func performFetch() {
            do {
                try favoritesController.performFetch()
                favorites = favoritesController.fetchedObjects ?? []
            } catch {
                print("Failed to fetch initial data.")
            }
        }

        func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
            performFetch()
        }

        func getUnit(_ name: String) -> UnitObject {
            UnitObject.allUnits.filter { $0.name == name}.first!
        }

        func reloadFavorites() {
            //favorites = archive.favoriteUnitConversions
        }
    }
}
