//
//  UnitConversionView.swift
//  UnitConversionApp
//
//  Created by Marwa Abou Niaaj on 12/08/2022.
//

import SwiftUI

struct UnitConversionView: View {
    @ObservedObject private var settings = AppSettings.shared

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
                    Text("Convert from")
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

                HStack {
                    Text("Convert to")
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
            }

            Section {
                TextField("Input", value: $viewModel.inputValue, format: .number)
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)
            } header: {
                Text("Amount to convert")
                    .font(.body)
                    .textCase(.none)
                    .foregroundColor(Color.accentColor)
            }

            Section {
                Text(outputNumber)
            } header: {
                Text("Result")
                    .font(.body)
                    .textCase(.none)
                    .foregroundColor(Color.accentColor)
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
                    Label("Hide keyboard", systemImage: "keyboard.chevron.compact.down")
                }
            }
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    viewModel.isFavorite.toggle()
                    viewModel.toggleFavorite()
                } label: {
                    Label(
                        "Toggle favorite",
                        systemImage: viewModel.isFavorite ? "star.fill" : "star"
                    )
                    .foregroundColor(Color.accentColor)
                }
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
        }
    }

    init(unit: Unit) {
        let viewModel = ViewModel(unit: unit)
        _viewModel = StateObject(wrappedValue: viewModel)

        longFormatter = MeasurementFormatter()
        longFormatter.unitOptions = .providedUnit
        longFormatter.unitStyle = .long

        shortFormatter = MeasurementFormatter()
        shortFormatter.unitOptions = .providedUnit
        shortFormatter.unitStyle = .medium
    }

    init(unit: Unit, convertFrom: Dimension, convertTo: Dimension, value: Double) {
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
            UnitConversionView(unit: Unit.Sample)
        }
    }
}
