//
//  ListType.swift
//  GraphQL Viewer
//
//  Created by david-swift on 20.06.2023.
//

import GraphQLLanguage
import SwiftUI

extension ListType: TypeReferenceProtocol {

    /// The child's type.
    var child: TypeReferenceProtocol? {
        typeReference as? TypeReferenceProtocol
    }
    /// The type name of the content without a questionmark or brackets.
    var type: String {
        child?.type ?? "String"
    }
    /// The Swift type name of the content without a questionmark or brackets.
    var swiftType: String {
        child?.swiftType ?? "String"
    }
    /// The type's description.
    var description: String {
        notOptionalDescription + "?"
    }
    /// The type's description, but not optional.
    var notOptionalDescription: String {
        "[" + swiftType + "]"
    }

    /// Get a SwiftUI text view.
    /// - Parameter color: The type' accent color.
    /// - Returns: The text view.
    func text(color: Color) -> Text {
        notOptionalText(color: color) + .init("?").foregroundColor(color)
    }
    /// Get a SwiftUI text view, but not optional.
    /// - Parameter color: The type' accent color.
    /// - Returns: The text view.
    func notOptionalText(color: Color) -> Text {
        .init("[").foregroundColor(color)
        + (child?.text(color: color) ?? .init("String"))
        + .init("]").foregroundColor(color)
    }

}
