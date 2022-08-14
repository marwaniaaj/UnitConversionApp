//
//  AppSettings.swift
//  Unitify
//
//  Created by Marwa Abou Niaaj on 05/08/2022.
//

import Foundation

final class AppSettings: ObservableObject {

    static let shared = AppSettings()
    private init() {}

    @Published var theme = Theme()

    @Published var favoritesArchive = FavoritesArchive()
}
