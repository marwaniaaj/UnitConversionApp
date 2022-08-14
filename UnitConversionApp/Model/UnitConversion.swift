//
//  UnitConversion.swift
//  UnitConversionApp
//
//  Created by Marwa Abou Niaaj on 08/08/2022.
//

import Foundation


@objc(UnitConversion)
class UnitConversion: NSObject, Identifiable, NSSecureCoding {
    var id: UUID
    var convertFrom: Dimension
    var convertTo: Dimension
    var unit: String
    var value: Double = 0.0

    static var supportsSecureCoding: Bool {
        return true
    }

    init(convertFrom: Dimension, convertTo: Dimension, unit: String, value: Double) {
        self.id = UUID()
        self.convertFrom = convertFrom
        self.convertTo = convertTo
        self.unit = unit
        self.value = value
    }

    required init?(coder: NSCoder) {
        guard
            let id = coder.decodeObject(of: [NSUUID.self], forKey: "id") as? UUID,
            let convertFrom = coder.decodeObject(of: [Dimension.self], forKey: "convertFrom") as? Dimension,
            let convertTo = coder.decodeObject(of: [Dimension.self], forKey: "convertTo") as? Dimension,
            let unit = coder.decodeObject(of: [NSString.self], forKey: "unit") as? String
        else {
            return nil
        }

        let value = coder.decodeDouble(forKey: "value")

        self.id = id
        self.convertFrom = convertFrom
        self.convertTo = convertTo
        self.unit = unit
        self.value = value
    }

    func encode(with coder: NSCoder) {
        coder.encode(id, forKey: "id")
        coder.encode(convertFrom, forKey: "convertFrom")
        coder.encode(convertTo, forKey: "convertTo")
        coder.encode(unit, forKey: "unit")
        coder.encode(value, forKey: "value")
    }
}

@objc(Conversions)
class Conversions: NSObject, NSSecureCoding {

    var units: [UnitConversion]?

    static var supportsSecureCoding: Bool {
        return true
    }

    override init() {
        super.init()
        self.units = []
    }
    
    required init?(coder: NSCoder) {
        guard
            let units = coder.decodeObject(of: [NSArray.self, Dimension.self, NSString.self, Conversions.self, UnitConversion.self], forKey: "units") as? [UnitConversion]
        else {
            return nil
        }

        self.units = units
    }

    func encode(with coder: NSCoder) {
        if let units = units {
            coder.encode(units, forKey: "units")
        }
    }

}
