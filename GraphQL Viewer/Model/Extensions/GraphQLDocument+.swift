//
//  GraphQLDocument+.swift
//  GraphQL Viewer
//
//  Created by david-swift on 02.07.2023.
//

import Foundation
import GraphQLLanguage

extension GraphQLDocument {

    /// Create a directory for one defintion type and its content.
    /// - Parameters:
    ///   - category: The definition type.
    ///   - packageName: The package name.
    ///   - creatorName: The creator name.
    ///   - scalars: The scalars.
    ///   - url: The URL.
    func createSourceFolder(
        category: Definition,
        packageName: String,
        creatorName: String,
        scalars: [String: String],
        at url: URL
    ) throws {
        let contentURL = url.appending(component: category.name.key.filter { !$0.isWhitespace })
        try fileManager.createDirectory(at: contentURL, withIntermediateDirectories: true)
        for definition in category.getDefinitions(definitions: document.definitions) {
            let firstLetter = String(definition.name.prefix(1)).uppercased()
            var otherLetters = definition.name.dropFirst()
            if category == .queryDefinitions {
                otherLetters += "Query"
            } else if category == .mutationDefinitions {
                otherLetters += "Mutation"
            }
            let name = firstLetter + otherLetters
            let enums = Definition.enumTypeDefinitions
                .getDefinitions(definitions: document.definitions)
                .map { $0.name }
            let objects = Definition.objectTypeDefinitions
                .getDefinitions(definitions: document.definitions)
                .compactMap { $0 as? ObjectTypeDefinition }
            // swiftlint:disable trailing_whitespace
            let code = """
            //
            //  \(name).swift
            //  \(packageName)
            //
            //  Created by \(creatorName) on \(getDate()).
            //
            
            import Foundation
            import GraphQLKit
            import SwiftyJSON
            
            \(definition.code(name: name, scalars: scalars, enums: enums, objects: objects))
            
            """
            // swiftlint:enable trailing_whitespace
            try createFile(name: name, withExtension: "swift", content: code, at: contentURL)
        }
    }

    /// Create the ".github" directory.
    /// - Parameter packageURL: The URL to the package.
    func createHiddenGitHubDirectory(packageURL: URL) throws {
        try copyFile(name: ".github", withExtension: nil, to: packageURL)
    }

    /// Create the ".gitignore" file.
    /// - Parameter packageURL: The URL to the package.
    func createHiddenGitignoreFile(packageURL: URL) throws {
        try copyFile(name: ".gitignore", withExtension: nil, to: packageURL)
    }

    /// Create the ".swiftlint.yml" file.
    /// - Parameters:
    ///   - packageName: The package name.
    ///   - repositoryGitHub: The URL to the GitHub repository.
    ///   - packageURL: The URL to the package.
    func createHiddenSwiftlintFile(packageName: String, repositoryGitHub: String, packageURL: URL) throws {
        let url = try copyFile(name: ".swiftlint", withExtension: "yml", to: packageURL)
        try replaceURL(repositoryGitHub: repositoryGitHub, url: url)
        try replace(sequence: "GraphQL Viewer", with: packageName, url: url)
        try replace(
            sequence: "disabled_rules:",
            with: """
            disabled_rules:
                - line_length
                - redundant_optional_initialization
                - type_name
                - identifier_name
                - type_body_length
                - file_length
                - string_literals
            """,
            url: url
        )
        // swiftlint:disable trailing_whitespace
        try replace(
            sequence: """
            
                - discouraged_optional_collection
            """,
            with: "",
            url: url
        )
        try replace(
            sequence: """
            
                - discouraged_optional_boolean
            """,
            with: "",
            url: url
        )
        try replace(
            sequence: """
            
                - attributes
            """,
            with: "",
            url: url
        )
        try replace(sequence: "- lower_acl_than_parent", with: "", url: url)
        // swiftlint:enable trailing_whitespace
    }

    /// Replace the GitHub URL in the ".swiftlint" file.
    /// - Parameters:
    ///   - repositoryGitHub: The GitHub URL.
    ///   - url: The ".swiftlint" file.
    func replaceURL(repositoryGitHub: String, url: URL) throws {
        try replace(
            sequence: "https://github\\.com/david-swift/GraphQL-Viewer-macOS",
            with: repositoryGitHub.map { character in
                if character == "." {
                    return "\\."
                } else {
                    return String(character)
                }
            }
            .joined(),
            url: url
        )
    }

    /// Create the "CONTRIBUTING.md" file.
    /// - Parameter packageURL: The package URL.
    func createCONTRIBUTINGFile(packageURL: URL) throws {
        try copyFile(name: "CONTRIBUTING", withExtension: "md", to: packageURL)
    }

    /// Create the Contributors.md file.
    /// - Parameters:
    ///   - contributorName: The contributor's name.
    ///   - contributorGitHub: The contributor's GitHub URL.
    ///   - packageURL: URL ot the package.
    func createContributorsFile(contributorName: String, contributorGitHub: String, packageURL: URL) throws {
        let url = try copyFile(name: "Contributors", withExtension: "md", to: packageURL)
        try replace(sequence: "https://github.com/david-swift", with: contributorGitHub, url: url)
        try replace(sequence: "[david-swift]", with: "[\(contributorName)]", url: url)
    }

    /// Create the "Icons" directory.
    /// - Parameter packageURL: URL to the package.
    func createIconsDirectory(packageURL: URL) throws {
        try copyFile(name: "Icons", withExtension: nil, to: packageURL)
    }

    /// Create the "LICENSE.md" file.
    /// - Parameters:
    ///   - contributorName: The contributor's name.
    ///   - packageURL: The URL to the package.
    func createLicenseFile(contributorName: String, packageURL: URL) throws {
        let url = try copyFile(name: "LICENSE", withExtension: "md", to: packageURL)
        try replace(sequence: "david-swift", with: contributorName, url: url)
        try replace(sequence: "2023", with: getDate(format: "YYYY"), url: url)
    }

    /// Create the "Package.swift" file.
    /// - Parameters:
    ///   - packageName: The package name.
    ///   - creatorName: The creator's name.
    ///   - packageURL: The URL to the package.
    func createPackageFile(packageName: String, creatorName: String, packageURL: URL) throws {
        // swiftlint:disable trailing_whitespace
        let content = """
        //  swift-tools-version: 5.9
        //
        //  Package.swift
        //  \(packageName)
        //
        //  Created by \(creatorName) on \(getDate())
        //
        
        import PackageDescription
        
        /// The \(packageName) package.
        let package = Package(
            name: "\(packageName)",
            platforms: [
                .macOS(.v13)
            ],
            products: [
                .library(
                    name: "\(packageName)",
                    targets: ["\(packageName)"]
                )
            ],
            dependencies: [
                .package(url: "https://github.com/david-swift/GraphQLKit-macOS", from: "0.1.4"),
                .package(url: "https://github.com/SwiftyJSON/SwiftyJSON", from: "5.0.0"),
                .package(url: "https://github.com/lukepistrol/SwiftLintPlugin", from: "0.52.3")
            ],
            targets: [
                .target(
                    name: "\(packageName)",
                    dependencies: [
                        .product(name: "GraphQLKit", package: "GraphQLKit-macOS"),
                        .product(name: "SwiftyJSON", package: "SwiftyJSON")
                    ],
                    plugins: [
                        .plugin(name: "SwiftLint", package: "SwiftLintPlugin")
                    ]
                )
            ]
        )
        """
        // swiftlint:enable trailing_whitespace
        try createFile(name: "Package", withExtension: "swift", content: content, at: packageURL)
    }

    /// Create the "Makefile".
    /// - Parameter packageURL: The URL to the package.
    func createMakefile(packageURL: URL) throws {
        // swiftlint:disable trailing_whitespace
        let content = """
        docs:
        \t@sourcedocs generate -a --min-acl private -r
        
        swiftlint:
        \t@swiftlint --autocorrect
        """
        // swiftlint:enable trailing_whitespace
        try createFile(name: "Makefile", withExtension: nil, content: content, at: packageURL)
    }

    // swiftlint:disable function_body_length line_length
    /// Create the "README.md" file.
    /// - Parameters:
    ///   - packageName: The package name.
    ///   - repositoryGitHub: The URL to the GitHub repository.
    ///   - packageURL: The URL to the package.
    func createREADMEFile(packageName: String, repositoryGitHub: String, packageURL: URL) throws {
        // swiftlint:disable trailing_whitespace
        let content = """
        <p align="center">
          <img width="256" alt="\(packageName) Icon" src="Icons/Icon.png">
          <h1 align="center">\(packageName)</h1>
        </p>
        
        <p align="center">
          <a href="\(repositoryGitHub)">
          GitHub
          </a>
          ·
          <a href="Documentation/Reference/\(packageName)/README.md">
          Contributor Docs
          </a>
        </p>
        
        _\(packageName)_ is a GraphQL package for Swift, created using the [GraphQL Viewer][1] app. It enables creating queries and mutations using a type-safe, easy-to-use interface.
        
        ## Table of Contents
        
        - [Installation][2]
        - [Usage][3]
        - [Thanks][4]
        
        ## Installation
        
        ### Swift Package
        1. Open your Swift package in Xcode.
        2. Navigate to `File > Add Packages`.
        3. Paste this URL into the search field: `\(repositoryGitHub)`
        4. Click on `Copy Dependency`.
        5. Navigate to the `Package.swift` file.
        6. In the `Package` initializer, under `dependencies`, paste the dependency into the array.
        
        ###  Xcode Project
        1. Open your Xcode project in Xcode.
        2. Navigate to `File > Add Packages`.
        3. Paste this URL into the search field: `\(repositoryGitHub)`
        4. Click on `Add Package`.
        
        ## Usage
        
        Creating a request is really simple. Here is an example on how to transfer a GraphQL query to Swift. Note that this example is using the GraphQLZero API.
        
        ```swift
        try await GraphQL(url: "https://graphqlzero.almansi.me/api").query {
            UserQuery(id: "1", fields: .init(
                id: { print($0) },
                address: .init(
                    geo: .init(
                        lat: { print($0) },
                        lng: { print($0) }
                    )
                )
            ))
        }
        ```
        
        That is an example implementation of the following query:
        
        ```graphql
        query {
          user(id: "1") {
            id
            address {
              geo {
                lat
                lng
              }
            }
          }
        }
        ```
        
        Instead of getting the data and having to manually find the data you requested in a second step, only one step is required in `GraphQLKit`. You define what happens after fetching the data at the same time as you define what data to fetch. In the example above, the data is printed after being fetched successfully.
        
        Many Swift features, such as loops, switch statements, and many more, enhance the way you create GraphQL requests.
        
        For mutations, use `mutation(mutations:getRequest:)` instead of `query(queries:getRequest:)`.
        
        ## Thanks
        
        ### Dependencies
        -  [GraphQLKit][5] licensed under the [MIT license][6]
        - [SwiftLintPlugin][7] licensed under the [MIT license][8]
        
        ### Other Thanks
        - The [contributors][9]
        - [SourceDocs][10] used for generating the [docs][11]
        - [SwiftLint][12] for checking whether code style conventions are violated
        - The programming language [Swift][13]
        
        [1]:    https://github.com/david-swift/GraphQL-Viewer-macOS
        [2]:    #Installation
        [3]:    #Usage
        [4]:    #Thanks
        [5]:    https://github.com/david-swift/GraphQLKit-macOS/
        [6]:    https://github.com/david-swift/GraphQLKit-macOS/blob/main/LICENSE.md
        [7]:    https://github.com/lukepistrol/SwiftLintPlugin
        [8]:    https://github.com/lukepistrol/SwiftLintPlugin/blob/main/LICENSE
        [9]:    Contributors.md
        [10]:    https://github.com/SourceDocs/SourceDocs
        [11]:    Documentation/Reference/ActionKit/README.md
        [12]:    https://github.com/realm/SwiftLint
        [13]:    https://github.com/apple/swift
        """
        // swiftlint:enable trailing_whitespace
        try createFile(name: "README", withExtension: "md", content: content, at: packageURL)
    }
    // swiftlint:enable function_body_length line_length

    /// Copy a file from the Bundle to a URL.
    /// - Parameters:
    ///   - name: The file name.
    ///   - withExtension: The file's extension.
    ///   - url: The destination.
    /// - Returns: The URL to the new file in the destination.
    @discardableResult
    private func copyFile(name: String, withExtension: String?, to url: URL) throws -> URL {
        guard let bundleFileURL = Bundle.main.url(forResource: name, withExtension: withExtension) else {
            throw DocumentError.error
        }
        let fileName = bundleFileURL.lastPathComponent
        let destinationFileURL = url.appending(path: fileName)
        try fileManager.copyItem(at: bundleFileURL, to: destinationFileURL)
        return destinationFileURL
    }

    /// Replace a sequence in a file.
    /// - Parameters:
    ///   - sequence: The sequence.
    ///   - replacingSequence: The text that should be inserted instead of the sequence.
    ///   - url: The file URL.
    private func replace(sequence: String, with replacingSequence: String, url: URL) throws {
        let fileContents = try String(contentsOf: url)
        let modifiedContents = fileContents.replacingOccurrences(of: sequence, with: replacingSequence)
        try modifiedContents.write(to: url, atomically: true, encoding: .utf8)
    }

}
