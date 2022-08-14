//
//  UnitConversionView.swift
//  Unitify
//
//  Created by Marwa Abou Niaaj on 06/08/2022.
//

import SwiftUI

struct UnitConversionView: View {
    @ObservedObject private var settings = AppSettings.shared
    
    @EnvironmentObject var dataController: DataController
    @StateObject var viewModel: ViewModel
    
    @FocusState private var amountIsFocused: Bool

    let longFormatter: MeasurementFormatter
    let shortFormatter: MeasurementFormatter

    var outputNumber: String {
        let fromMeasurement = Measurement(value: viewModel.inputValue, unit: viewModel.inputUnit)
        let toMeasurement = fromMeasurement.converted(to: viewModel.outputUnit)
        
        return shortFormatter.string(from: toMeasurement)
    }

    var body: some View {
        Form {
            Section {
                HStack {
                    Text("ConvertFrom")
                        .font(.title3)

                    Spacer()

                    Menu {
                        Picker(selection: $viewModel.inputUnit) {
                            ForEach(viewModel.unitTypes, id: \.self) {
                                Text(longFormatter.string(from: $0).capitalized)
                            }
                        } label: {}
                    } label: {
                        Text(longFormatter.string(from: viewModel.inputUnit).capitalized).bold()
                        + Text(" \(Image(systemName: "chevron.up.chevron.down"))")
                    }
                }
                .accessibilityElement(children: .combine)
                .accessibility(label: Text("ConvertFrom") + Text(longFormatter.string(from: viewModel.inputUnit)))

                HStack {
                    Text("ConvertTo")
                        .font(.title3)

                    Spacer()

                    Menu {
                        Picker(selection: $viewModel.outputUnit) {
                            ForEach(viewModel.unitTypes, id: \.self) {
                                Text(longFormatter.string(from: $0).capitalized)
                            }
                        } label: {}
                    } label: {
                        Text(longFormatter.string(from: viewModel.outputUnit).capitalized).bold()
                        + Text(" \(Image(systemName: "chevron.up.chevron.down"))")
                    }
                }

                .accessibilityElement(children: .combine)
                .accessibility(label: Text("ConvertTo") + Text(longFormatter.string(from: viewModel.outputUnit)))
            }

            Section {
                TextField("Input", value: $viewModel.inputValue, format: .number)
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)
            } header: {
                Text("AmountToConvert")
                    .font(.body)
                    .textCase(.none)
                    .foregroundColor(settings.theme.primaryColor)
            }

            Section {
                Text(outputNumber)
            } header: {
                Text("Output")
                    .font(.body)
                    .textCase(.none)
                    .foregroundColor(settings.theme.primaryColor)
            }
        }
        .navigationTitle(LocalizedStringKey(viewModel.unit.name))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button {
                    amountIsFocused = false
                } label: {
                    Label("HideKeyboard", systemImage: "keyboard.chevron.compact.down")
                }
            }
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    viewModel.isFavorite.toggle()
                    viewModel.toggleFavorite()
                } label: {
                    Label(
                        viewModel.isFavorite ? "RemoveFromFavorite" : "AddToFavorite",
                        systemImage: viewModel.isFavorite ? "star.fill" : "star"
                    )
                        .foregroundColor(settings.theme.primaryColor)
                }
                .buttonStyle(FavoriteButtonStyle(isFavorite: viewModel.isFavorite))
            }
        }

        .onChange(of: viewModel.inputUnit) { _ in
            viewModel.checkFavorite()
        }
        .onChange(of: viewModel.outputUnit) { _ in
            viewModel.checkFavorite()
        }
        .onAppear {
            viewModel.checkFavorite()
            viewModel.updateUnit()
        }
    }

    init(unit: UnitObject) {
        let viewModel = ViewModel(unit: unit)
        _viewModel = StateObject(wrappedValue: viewModel)

        longFormatter = MeasurementFormatter()
        longFormatter.unitOptions = .providedUnit
        longFormatter.unitStyle = .long

        shortFormatter = MeasurementFormatter()
        shortFormatter.unitOptions = .providedUnit
        shortFormatter.unitStyle = .medium
    }

    init(unit: UnitObject, convertFrom: Dimension, convertTo: Dimension, value: Double) {
        let viewModel = ViewModel(unit: unit, convertFrom: convertFrom, convertTo: convertTo, value: value)
        _viewModel = StateObject(wrappedValue: viewModel)

        longFormatter = MeasurementFormatter()
        longFormatter.unitOptions = .providedUnit
        longFormatter.unitStyle = .long

        shortFormatter = MeasurementFormatter()
        shortFormatter.unitOptions = .providedUnit
        shortFormatter.unitStyle = .medium
    }
}

struct UnitConversionView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            UnitConversionView(unit: UnitObject.Sample)
        }
        .environmentObject(DataController.preview)
    }
}
