//
//  HomeView.swift
//  UnitConversionApp
//
//  Created by Marwa Abou Niaaj on 12/08/2022.
//

import SwiftUI

struct HomeView: View {
    static let tag: String? = "Home"

    @StateObject var viewModel: ViewModel

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.units, id: \.self) { unit in
                    NavigationLink(destination: UnitConversionView(unit: unit)) {
                        HStack {
                            Image(systemName: unit.icon)
                                .font(.title2)
                                .frame(width: 32, height: 32)
                                .foregroundColor(Color.accentColor)

                            Text(LocalizedStringKey(unit.name))
                                .font(.title3)
                                .foregroundColor(.primary)

                            Spacer()
                        }
                    }
                }
            }
            .listStyle(.sidebar)
            .navigationTitle("Units")
            .onAppear {
                viewModel.saveUnits()
            }
        }
    }

    init() {
        let viewModel = ViewModel()
        _viewModel = StateObject(wrappedValue: viewModel)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()

    }
}
