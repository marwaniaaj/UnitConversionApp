//
//  AppSettings.swift
//  UnitConversionApp
//
//  Created by Marwa Abou Niaaj on 12/08/2022.
//

import Foundation

/// An environment singleton responsible for shared app settings
final class AppSettings: ObservableObject {

    static let shared = AppSettings()
    private init() {}

    @Published var favoritesArchive = FavoritesArchive()
}
