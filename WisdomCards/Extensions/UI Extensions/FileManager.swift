//
//  FileManager.swift
//  WisdomCards
//
//  Created by NAVEEN MADHAN on 12/13/21.
//

import Foundation

extension FileManager {
    /// Read from a JSON file at a given path.
    ///
    /// - Parameters:
    ///   - path: JSON file path.
    ///   - readingOptions: JSONSerialization reading options.
    /// - Throws: Throws any errors thrown by Data creation or JSON serialization.
    /// - Returns: Optional dictionary.
    func jsonFromFile(
        atPath path: String,
        readingOptions: JSONSerialization.ReadingOptions = .allowFragments) throws -> [String: Any]? {
        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        let json = try JSONSerialization.jsonObject(with: data, options: readingOptions)

        return json as? [String: Any]
    }

    /// Read from a JSON file with a given filename.
    ///
    /// - Parameters:
    ///   - filename: File to read.
    ///   - bundleClass: Bundle where the file is associated.
    ///   - readingOptions: JSONSerialization reading options.
    /// - Throws: Throws any errors thrown by Data creation or JSON serialization.
    /// - Returns: Optional dictionary.
    func jsonFromFile(
        withFilename filename: String,
        at bundleClass: AnyClass? = nil,
        readingOptions: JSONSerialization.ReadingOptions = .allowFragments) throws -> [String: Any]? {
        // https://stackoverflow.com/questions/24410881/reading-in-a-json-file-using-swift
        // To handle cases that provided filename has an extension
        let name = filename.components(separatedBy: ".")[0]
        let bundle = bundleClass != nil ? Bundle(for: bundleClass!) : Bundle.main

        if let path = bundle.path(forResource: name, ofType: "json") {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let json = try JSONSerialization.jsonObject(with: data, options: readingOptions)

            return json as? [String: Any]
        }

        return nil
    }

    /// Creates a unique directory for saving temporary files. The directory can be used to create multiple temporary files used for a common purpose.
    ///
    ///     let tempDirectory = try fileManager.createTemporaryDirectory()
    ///     let tempFile1URL = tempDirectory.appendingPathComponent(ProcessInfo().globallyUniqueString)
    ///     let tempFile2URL = tempDirectory.appendingPathComponent(ProcessInfo().globallyUniqueString)
    ///
    /// - Throws: An error if a temporary directory cannot be found or created.
    /// - Returns: A URL to a new directory for saving temporary files.
    func createTemporaryDirectory() throws -> URL {

        let temporaryDirectoryURL: URL
        if #available(OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
            temporaryDirectoryURL = temporaryDirectory
        } else {
            temporaryDirectoryURL = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
        }
        return try url(for: .itemReplacementDirectory,
                       in: .userDomainMask,
                       appropriateFor: temporaryDirectoryURL,
                       create: true)

    }
}
