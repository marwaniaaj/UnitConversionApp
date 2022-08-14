//
//  HomeView.swift
//  Unitify
//
//  Created by Marwa Abou Niaaj on 05/08/2022.
//

import SwiftUI

struct HomeView: View {
    static let tag: String? = "Home"

    @Environment(\.layoutDirection) var layoutDirection
    @ObservedObject private var settings = AppSettings.shared

    @StateObject var viewModel: ViewModel

//    var groupedUnits: [[UnitObject]] {
//        Dictionary(grouping: viewModel.units, by: { $0.category }).map { $0.value }
//    }

    var groupedUnits: [[Unit]] {
        Dictionary(grouping: viewModel.units, by: { $0.category }).map { $0.value }
    }

    var recentRows: [GridItem] {
        [GridItem(.fixed(130))]
    }

    var body: some View {
        NavigationView {
            List {
                if !viewModel.recentUnits.isEmpty {
                    Section(header:  UnitSectionHeader(title: "Recent")) {

                        ScrollView(.horizontal, showsIndicators: false) {
                            ScrollViewReader { scrollView in
                                HStack {
                                    ForEach(Array(viewModel.recentUnits.enumerated()), id: \.element) { index, unit in
//                                        NavigationLink(destination: UnitConversionView(unit: unit)) {
//                                            UnitItemView(unit: unit)
//                                        }
                                        HStack {
                                            Image(systemName: unit.symbol)
                                            Text(unit.unitName)
                                        }
                                        .id(index)
                                    }
                                    .onAppear {
                                        if layoutDirection == .rightToLeft {
                                            scrollView.scrollTo(0, anchor: .trailing)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .listRowBackground(Color(uiColor: UIColor.systemGroupedBackground))
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                }
                
//                ForEach(groupedUnits, id: \.self) { groupedConversions in
//                    Section {
//                        ForEach(groupedConversions, id: \.self) { unit in
//                            NavigationLink(destination: UnitConversionView(unit: unit)) {
//                                UnitItemRow(unit: unit)
//                            }
//                        }
//                    } header: {
//                        UnitSectionHeader(title: groupedConversions[0].category)
//                    }
//                }

//                ForEach (viewModel.conversions, id: \.self) { conversion in
                    Section {
                        ForEach(viewModel.units, id: \.self) { unit in
                        //ForEach(viewModel.getUnits(in: conversion.name), id: \.self) { unit in
//                            NavigationLink(destination: UnitConversionView(unit: unit)) {
//                                UnitItemRow(unit: unit)
//                            }
                            HStack {
                                Image(systemName: unit.symbol)
                                Text(unit.unitName)
                            }
                            .id(unit.id)
                        }
                    } header: {
                        //UnitSectionHeader(title: conversion.name)
                    }
                    .accessibilityRemoveTraits(.isHeader)
                //}
            }
            .listStyle(.insetGrouped)
            .listStyle(.sidebar)
            .navigationTitle("Units")
            .onAppear {
                viewModel.saveUnits()
            }

            HomeEmptyView()
        }
    }

    init(unitifyManager: UnitifyManager) {
        let viewModel = ViewModel(unitifyManager: unitifyManager)
        _viewModel = StateObject(wrappedValue: viewModel)
    }
}

struct HomeView_Previews: PreviewProvider {
    static let dataController = DataController.preview

    static var previews: some View {
        HomeView(unitifyManager: UnitifyManager(dataController: dataController))

    }
}
