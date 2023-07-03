//
//  FocusedValues.swift
//  GraphQL Viewer
//
//  Created by david-swift on 01.07.2023.
//

import SwiftUI

extension FocusedValues {

    /// The focused value for the document.
    var document: FocusedDocumentValue.Value? {
        get {
            self[FocusedDocumentValue.self]
        }
        set {
            self[FocusedDocumentValue.self] = newValue
        }
    }

    /// The focused document value key.
    struct FocusedDocumentValue: FocusedValueKey {

        // swiftlint:disable nesting
        /// The value type.
        typealias Value = GraphQLDocument
        // swiftlint:enable nesting

    }

}
