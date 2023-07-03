//
//  TypeReferenceProtocol.swift
//  GraphQL Viewer
//
//  Created by david-swift on 20.06.2023.
//

import SwiftUI

/// A protocol for type references.
protocol TypeReferenceProtocol {

    /// The type's name.
    var type: String { get }
    /// The type as a Swift type.
    var swiftType: String { get }
    /// The type's description.
    var description: String { get }
    /// The description but without the question mark if it is an optional type.
    var notOptionalDescription: String { get }

    /// The type's description as a text.
    /// - Parameter color: The accent color.
    /// - Returns: The text.
    func text(color: Color) -> Text
    /// The description as a text but without the question mark if it is an optional type.
    /// - Parameter color: The accent color.
    /// - Returns: The text.
    func notOptionalText(color: Color) -> Text

}
