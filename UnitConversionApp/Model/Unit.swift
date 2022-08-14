//
//  Unit.swift
//  UnitConversionApp
//
//  Created by Marwa Abou Niaaj on 05/08/2022.
//

import Foundation

class Unit: NSObject, Identifiable, Codable {
    var id: UUID { UUID() }
    var name: String
    var icon: String
    var category: String

    var symbol: String {
        if icon.isEmpty {
            return "lines.measurement.horizontal"
        }
        return icon
    }

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
            UnitLength.hectometers,
            UnitLength.decameters,
            UnitLength.meters,
            UnitLength.decimeters,
            UnitLength.centimeters,
            UnitLength.millimeters,
            UnitLength.micrometers,
            UnitLength.nanometers,
            UnitLength.picometers,
            UnitLength.inches,
            UnitLength.feet,
            UnitLength.yards,
            UnitLength.miles
        ],
        "Volume": [
            UnitVolume.teaspoons,
            UnitVolume.tablespoons,
            UnitVolume.fluidOunces,
            UnitVolume.cups,
            UnitVolume.metricCups,
            UnitVolume.quarts,
            UnitVolume.pints,
            UnitVolume.gallons,

            UnitVolume.liters,
            UnitVolume.deciliters,
            UnitVolume.centiliters,
            UnitVolume.milliliters
        ],
        "Angle": [
            UnitAngle.degrees,
            UnitAngle.radians,
            UnitAngle.gradians,
            UnitAngle.revolutions,
            UnitAngle.arcMinutes,
            UnitAngle.arcSeconds
        ],
        "Mass": [
            UnitMass.kilograms,
            UnitMass.grams,
            UnitMass.milligrams,
            UnitMass.micrograms,
            UnitMass.nanograms,
            UnitMass.ounces,
            UnitMass.pounds,
            UnitMass.carats
        ],
        "Duration": [
            UnitDuration.seconds,
            UnitDuration.minutes,
            UnitDuration.hours
        ],
        "Speed": [
            UnitSpeed.kilometersPerHour,
            UnitSpeed.milesPerHour,
            UnitSpeed.metersPerSecond,
            UnitSpeed.knots
        ],
        "Energy": [
            UnitEnergy.joules,
            UnitEnergy.calories,
            UnitEnergy.kilojoules,
            UnitEnergy.kilocalories,
            UnitEnergy.kilowattHours
        ],
        "Temperature": [
            UnitTemperature.fahrenheit,
            UnitTemperature.celsius,
            UnitTemperature.kelvin
        ],
        "Fuel Efficiency": [
            UnitFuelEfficiency.milesPerGallon,
            UnitFuelEfficiency.litersPer100Kilometers,
            UnitFuelEfficiency.milesPerImperialGallon
        ]
    ]
}
