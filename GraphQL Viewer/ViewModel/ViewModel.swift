//
//  ViewModel.swift
//  GraphQL Viewer
//
//  Created by david-swift on 11.06.2023.
//

import Foundation
import Observation

/// The model showing the active window's state.
class ViewModel: ObservableObject {

    /// The navigation information.
    @Published var navigation: [String] = []
    /// The selected definition.
    var selection: String? {
        get {
            navigation.last
        }
        set {
            if let newValue, newValue != navigation.last {
                navigation.append(newValue)
            }
        }
    }
    /// The filter string.
    @Published var search = ""
    // swiftlint:disable redundant_optional_initialization
    /// The search scope.
    @Published var searchScope: Definition? = nil
    // swiftlint:enable redundant_optional_initialization
    /// Whether the export sheet is visible.
    @Published var export = false
    /// The active package name in the export sheet.
    @Published var packageName = "Package"
    /// The active creator name in the export sheet.
    @Published var creatorName = "david-swift"
    /// The link to the creator's GitHub account in the export sheet.
    @Published var creatorGitHub = "https://github.com/david-swift"
    /// The link to the GitHub repo in the export sheet.
    @Published var repositoryGitHub = "https://github.com/david-swift/GraphQL-Viewer-macOS"
    /// The scalars and the associated Swift types.
    @Published var scalars: [(String, SwiftType)] = []

    /// Navigate back.
    func back() {
        _ = navigation.popLast()
    }

    /// Export the document.
    /// - Parameter document: The document.
    func export(document: GraphQLDocument) {
        scalars = Definition.scalarTypeDefinitions.getDefinitions(
            definitions: document.document.definitions
        )
        .map { ($0.name, .string) }
        export = true
    }

}
