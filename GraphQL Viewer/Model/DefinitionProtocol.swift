//
//  DefinitionProtocol.swift
//  GraphQL Viewer
//
//  Created by david-swift on 12.06.2023.
//

import Foundation
import GraphQLLanguage

// swiftlint:disable discouraged_optional_collection
/// A protocol to which every definition conforms.
protocol DefinitionProtocol {

    /// The definition's description.
    var description: Description? { get }
    /// The definition's name.
    var name: String { get }
    /// The source string.
    var sourceString: String? { get }
    /// The interfaces the definition implements.
    var implementsInterfaces: [NamedType]? { get }
    /// The directives of the definition.
    var directives: [Directive]? { get }
    /// The definition's arguments.
    var argumentsDefinition: [InputValueDefinition]? { get }
    /// The definition's fields.
    var fieldsDefinition: [FieldDefinition]? { get }
    /// The definition's return type.
    var type: TypeReference? { get }
    /// The directive locations of a directive definition.
    var directiveLocations: [DirectiveLocation] { get }
    /// The cases of a enumeration definition.
    var enumValuesDefinition: [EnumValueDefinition]? { get }
    /// The types of a union definition.
    var unionMemberTypes: [NamedType]? { get }
    /// Get a representation in Swift code.
    /// - Parameters:
    ///   - name: The type name in Swift.
    ///   - scalars: The Swift equivalents to the scalars.
    ///   - enums: A list of all of the enumerations.
    ///   - objects: A list of all of the objects.
    /// - Returns: The code.
    func code(name: String, scalars: [String: String], enums: [String], objects: [ObjectTypeDefinition]) -> String

}

extension DefinitionProtocol {

    /// The definition's description as an optional string.
    var stringDescription: String? { description?.stringValue.stringValue }
    /// The interfaces as an optional string array.
    var stringImplementsInterfaces: [String]? { implementsInterfaces?.map { $0.name } }

}

// swiftlint:enable discouraged_optional_collection
