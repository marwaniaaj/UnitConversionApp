//
//  Unit.swift
//  UnitConversionApp
//
//  Created by Marwa Abou Niaaj on 12/08/2022.
//

import Foundation

/// An object representing the unit of measures, and unit types.
/// 
/// All unit types are from [Units and Measurement](https://developer.apple.com/documentation/foundation/units_and_measurement)
class Unit: NSObject, Identifiable, Codable {
    var id: UUID { UUID() }
    var name: String
    var icon: String

    static let allUnits = Bundle.main.decode([Unit].self, from: "Units.json")
    static let Sample = allUnits[2]

    static let unitTypes = [
        "Area": [
            UnitArea.squareKilometers,
            UnitArea.squareMeters,
            UnitArea.squareCentimeters,
            UnitArea.squareInches,
            UnitArea.squareFeet,
            UnitArea.squareMiles,
            UnitArea.squareYards,
            UnitArea.acres,
            UnitArea.hectares
        ],
        "Length": [
            UnitLength.kilometers,
            UnitLength.meters,
            UnitLength.centimeters,
            UnitLength.millimeters,
            UnitLength.inches,
            UnitLength.feet,
            UnitLength.yards,
            UnitLength.miles
        ],
        "Volume": [
            UnitVolume.fluidOunces,
            UnitVolume.cups,
            UnitVolume.quarts,
            UnitVolume.pints,
            UnitVolume.liters,
            UnitVolume.milliliters,
            UnitVolume.teaspoons,
            UnitVolume.tablespoons,
        ],
        "Mass": [
            UnitMass.kilograms,
            UnitMass.grams,
            UnitMass.milligrams,
            UnitMass.ounces,
            UnitMass.pounds
        ],
        "Duration": [
            UnitDuration.seconds,
            UnitDuration.minutes,
            UnitDuration.hours
        ],
        "Speed": [
            UnitSpeed.kilometersPerHour,
            UnitSpeed.milesPerHour,
            UnitSpeed.metersPerSecond
        ],
        "Energy": [
            UnitEnergy.joules,
            UnitEnergy.calories,
            UnitEnergy.kilojoules,
            UnitEnergy.kilocalories
        ],
        "Temperature": [
            UnitTemperature.fahrenheit,
            UnitTemperature.celsius,
            UnitTemperature.kelvin
        ]
    ]
}
