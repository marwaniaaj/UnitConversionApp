//
//  ContentView.swift
//  UnitConversionApp
//
//  Created by Marwa Abou Niaaj on 12/08/2022.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        TabView {
            HomeView()
                .tag(HomeView.tag)
                .tabItem {
                    Image(systemName: "lines.measurement.horizontal")
                    Text("Units")
                }

            FavoritesView()
                .tag(FavoritesView.tag)
                .tabItem {
                    Image(systemName: "star")
                    Text("Favorites")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
