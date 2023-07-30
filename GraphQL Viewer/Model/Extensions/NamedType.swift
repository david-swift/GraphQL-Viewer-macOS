//
//  NamedType.swift
//  GraphQL Viewer
//
//  Created by david-swift on 20.06.2023.
//

import GraphQLLanguage
import SwiftUI

extension NamedType: TypeReferenceProtocol {

    /// The type name of the content without a questionmark or brackets.
    var type: String {
        getString { $0.rawValue }
    }
    /// The Swift type name of the content without a questionmark or brackets.
    var swiftType: String {
        getString { $0.swift }.getTypeName()
    }
    /// The type's description, but not optional.
    var notOptionalDescription: String {
        swiftType
    }
    /// The type's description.
    var description: String {
        swiftType + "?"
    }

    /// Get the type name.
    /// - Parameter getType: Convert a default type to a type name.
    /// - Returns: The type name.
    func getString(getType: (DefaultType) -> String) -> String {
        if let scalar = DefaultType(rawValue: name) {
            return getType(scalar)
        } else {
            return name
        }
    }

    /// Get a SwiftUI text view.
    /// - Parameter color: The type' accent color.
    /// - Returns: The text view.
    func text(color: Color) -> Text {
        .init(type) + .init("?").foregroundColor(color)
    }
    /// Get a SwiftUI text view, but not optional.
    /// - Parameter color: The type' accent color.
    /// - Returns: The text view.
    func notOptionalText(color: Color) -> Text {
        .init(type)
    }

}
