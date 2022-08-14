//
//  FileManager-DocumentsDirectory.swift
//  Unitify
//
//  Created by Marwa Abou Niaaj on 08/08/2022.
//

import Foundation

extension FileManager {

    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    func encode<T: Encodable>(_ input: T, to file: String,
                              dateDecodingStrategy: JSONEncoder.DateEncodingStrategy = .deferredToDate,
                              keyDecodingStrategy: JSONEncoder.KeyEncodingStrategy = .useDefaultKeys) {

        let url = Self.documentsDirectory.appendingPathComponent(file)

        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = dateDecodingStrategy
        encoder.keyEncodingStrategy = keyDecodingStrategy

        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]

        do {
            let data = try encoder.encode(input)
            //printData(data)
            try data.write(to: url, options: [.atomic, .completeFileProtection])
        } catch {
            fatalError("Failed to write data to file \(url): \(error) - \(error.localizedDescription)")
        }
    }

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

    private func printData(_ data: Data) {
        let jsonString = String(data: data, encoding: .utf8)
        print(jsonString ?? "No data")
    }
}
