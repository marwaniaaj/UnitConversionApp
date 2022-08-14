//
//  FileManager-Codable.swift
//  UnitConversionApp
//
//  Created by Marwa Abou Niaaj on 14/08/2022.
//

import Foundation

extension FileManager {

    /// Encode given object, and write JSON data to given file path.
    /// - Parameters:
    ///   - input: Object to be encoded.
    ///   - file: String representing file name.
    ///   - dateDecodingStrategy: The strategy used when encoding dates as part of a JSON object.
    ///   - keyDecodingStrategy: The values that determine how to encode a type's coding keys as JSON keys.
    func encode<T: Encodable>(_ input: T, to file: String,
                              dateDecodingStrategy: JSONEncoder.DateEncodingStrategy = .deferredToDate,
                              keyDecodingStrategy: JSONEncoder.KeyEncodingStrategy = .useDefaultKeys) {

        let url = Self.documentsDirectory.appendingPathComponent(file)

        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = dateDecodingStrategy
        encoder.keyEncodingStrategy = keyDecodingStrategy

        // The following line is used to print data in a nice readable output.
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]

        do {
            let data = try encoder.encode(input)

            // Uncomment the following line to print out encoded data
            //printData(data)

            try data.write(to: url, options: [.atomic, .completeFileProtection])
        } catch {
            fatalError("Failed to write data to file \(url): \(error) - \(error.localizedDescription)")
        }
    }

    /// Decode JSON data from given file, into given object type.
    /// - Parameters:
    ///   - type: The type of the value to decode.
    ///   - file: String representing file name.
    ///   - dateDecodingStrategy: The strategy used when decoding dates from part of a JSON object.
    ///   - keyDecodingStrategy: The values that determine how to decode a type's coding keys from JSON keys.
    /// - Returns: Returns a value of the type specified
    func decode<T: Decodable>(_ type: T.Type, from file: String,
                              dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
                              keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) -> T? {

        guard fileExists(atPath: Self.documentsDirectory.appendingPathComponent(file).path) else {
            return nil
        }

        let url = Self.documentsDirectory.appendingPathComponent(file)

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStrategy
        decoder.keyDecodingStrategy = keyDecodingStrategy

        do {
            let data = try Data(contentsOf: url)
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Failed to decode \(file): \(error.localizedDescription)")
        }
    }


    /// Convert given data to String and print it to console.
    ///
    /// Used for testing purposes
    /// - Parameter data: Data to be printed
    private func printData(_ data: Data) {
        let jsonString = String(data: data, encoding: .utf8)
        print(jsonString ?? "No data")
    }
}
