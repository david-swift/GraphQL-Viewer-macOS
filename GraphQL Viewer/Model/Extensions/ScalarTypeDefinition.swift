//
//  ScalarTypeDefinition.swift
//  GraphQL Viewer
//
//  Created by david-swift on 12.06.2023.
//
// swiftlint:disable discouraged_optional_collection

import Foundation
import GraphQLLanguage

extension ScalarTypeDefinition: DefinitionProtocol {

    /// A scalar type implements no interfaces.
    var implementsInterfaces: [NamedType]? { nil }
    /// A scalar type has not got any arguments.
    var argumentsDefinition: [InputValueDefinition]? { nil }
    /// A scalar type has no fields.
    var fieldsDefinition: [FieldDefinition]? { nil }
    /// A scalar type has no return type.
    var type: TypeReference? { nil }
    /// A scalar type has no directive locations.
    var directiveLocations: [DirectiveLocation] { [] }
    /// A scalar type has no enumeration cases.
    var enumValuesDefinition: [EnumValueDefinition]? { nil }
    /// A scalar type has no member types.
    var unionMemberTypes: [NamedType]? { nil }

    /// The Swift code.
    /// - Parameters:
    ///   - name: The type name.
    ///   - scalars: The document's scalars.
    ///   - enums: The document's enumerations.
    ///   - objects: The document's objects.
    /// - Returns: The code.
    func code(name: String, scalars: [String: String], enums: [String], objects: [ObjectTypeDefinition]) -> String {
        if let scalar = scalars[name] {
            return """
            /// \((description?.stringValue.stringValue).description)
            public typealias \(name) = \(scalar)
            """
        } else {
            // swiftlint:disable github_issue
            return "// FIXME: A Swift type for the scalar \"\(name)\" could not be found."
            // swiftlint:enable github_issue
        }
    }

}

// swiftlint:enable discouraged_optional_collection
