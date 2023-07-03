//
//  GraphQLDocument++.swift
//  GraphQL Viewer
//
//  Created by david-swift on 03.07.2023.
//

import Foundation
import GraphQLLanguage

extension GraphQLDocument {

    // swiftlint:disable function_parameter_count
    /// Create a Swift package.
    /// - Parameters:
    ///   - packageName: The package name.
    ///   - creatorName: The creator's name.
    ///   - creatorGitHub: A URL to the creator's GitHub account.
    ///   - repositoryGitHub: A URL to the repository on GitHub.
    ///   - scalars: The scalars and their Swift equivalents.
    ///   - targetDirectory: The URL to the directory where the package should be created.
    func createSwiftPackage(
        packageName: String,
        creatorName: String,
        creatorGitHub: String,
        repositoryGitHub: String,
        scalars: [String: String],
        targetDirectory: URL
    ) throws {
        var repositoryGitHub = repositoryGitHub
        if repositoryGitHub.hasSuffix("/") {
            repositoryGitHub.removeLast()
        }
        let packageURL = targetDirectory.appending(component: packageName)
        try createSourcesDirectory(
            packageName: packageName,
            creatorName: creatorName,
            scalars: scalars,
            packageURL: packageURL
        )
        try createHiddenGitHubDirectory(packageURL: packageURL)
        try createHiddenGitignoreFile(packageURL: packageURL)
        try createHiddenSwiftlintFile(
            packageName: packageName,
            repositoryGitHub: repositoryGitHub,
            packageURL: packageURL
        )
        try createCONTRIBUTINGFile(packageURL: packageURL)
        try createContributorsFile(
            contributorName: creatorName,
            contributorGitHub: creatorGitHub,
            packageURL: packageURL
        )
        try createIconsDirectory(packageURL: packageURL)
        try createLicenseFile(contributorName: creatorName, packageURL: packageURL)
        try createMakefile(packageURL: packageURL)
        try createPackageFile(packageName: packageName, creatorName: creatorName, packageURL: packageURL)
        try createREADMEFile(packageName: packageName, repositoryGitHub: repositoryGitHub, packageURL: packageURL)
    }
    // swiftlint:enable function_parameter_count

    /// Create the "Sources" directory.
    /// - Parameters:
    ///   - packageName: The package's name.
    ///   - creatorName: The creator's name.
    ///   - scalars: The available scalars.
    ///   - packageURL: The URL to the package.
    func createSourcesDirectory(
        packageName: String,
        creatorName: String,
        scalars: [String: String],
        packageURL: URL
    ) throws {
        let sourcesURL = packageURL.appending(component: "Sources").appending(component: packageName)
        try fileManager.createDirectory(at: sourcesURL, withIntermediateDirectories: true)
        for category in [
            Definition.queryDefinitions,
            .mutationDefinitions,
            .objectTypeDefinitions,
            .inputObjectTypeDefinitions,
            .enumTypeDefinitions,
            .unionTypeDefinitions,
            .scalarTypeDefinitions,
            .interfaceTypeDefinitions
        ] {
            try createSourceFolder(
                category: category,
                packageName: packageName,
                creatorName: creatorName,
                scalars: scalars,
                at: sourcesURL
            )
        }
    }

    /// Create a new file.
    /// - Parameters:
    ///   - name: The file name.
    ///   - withExtension: The file's extension.
    ///   - content: The file's content.
    ///   - url: The destination.
    func createFile(name: String, withExtension: String?, content: String, at url: URL) throws {
        let file: URL
        if let withExtension {
            file = url.appending(component: "\(name).\(withExtension)")
        } else {
            file = url.appending(component: name)
        }
        fileManager.createFile(atPath: file.path(), contents: content.data(using: .utf8))
    }

    /// Get the current date in a specified format.
    /// - Parameter format: The format.
    /// - Returns: The current date as a formatted string.
    func getDate(format: String = "dd.MM.YY") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: .now)
    }

}
