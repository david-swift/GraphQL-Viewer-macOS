//
//  ViewModel.swift
//  GraphQL Viewer
//
//  Created by david-swift on 11.06.2023.
//

import Foundation
import Observation

/// The model showing the active window's state.
@Observable
class ViewModel: ObservableObject {

    /// The navigation information.
    var navigation: [String] = []
    /// The selected definition.
    var selection: String? {
        get {
            navigation.last
        }
        set {
            if let newValue, newValue != navigation.last {
                navigation.append(newValue)
            }
            isPresented = false
        }
    }
    /// The filter string.
    var search = ""
    // swiftlint:disable redundant_optional_initialization
    /// The search scope.
    var searchScope: Definition? = nil
    // swiftlint:enable redundant_optional_initialization
    /// Whether the search is active.
    var isPresented = false
    /// Whether the export sheet is visible.
    var export = false
    /// The active package name in the export sheet.
    var packageName = "Package"
    /// The active creator name in the export sheet.
    var creatorName = "david-swift"
    /// The link to the creator's GitHub account in the export sheet.
    var creatorGitHub = "https://github.com/david-swift"
    /// The link to the GitHub repo in the export sheet.
    var repositoryGitHub = "https://github.com/david-swift/GraphQL-Viewer-macOS"
    /// The scalars and the associated Swift types.
    var scalars: [(String, SwiftType)] = []

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
