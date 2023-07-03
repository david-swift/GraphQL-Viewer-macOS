//
//  InterfaceTypeDefinition.swift
//  GraphQL Viewer
//
//  Created by david-swift on 12.06.2023.
//
// swiftlint:disable discouraged_optional_collection

import Foundation
import GraphQLLanguage

extension InterfaceTypeDefinition: DefinitionProtocol {

    /// The interface's implemented interfaces are always nil.
    var implementsInterfaces: [NamedType]? { nil }
    /// The interface's arguments definition is always nil.
    var argumentsDefinition: [InputValueDefinition]? { nil }
    /// The interface's return type is always nil.
    var type: TypeReference? { nil }
    /// The interace's directive locations definition is always empty.
    var directiveLocations: [DirectiveLocation] { [] }
    /// The interface's enumeration values definition is always nil.
    var enumValuesDefinition: [EnumValueDefinition]? { nil }
    /// The interface's union member types definition is always nil.
    var unionMemberTypes: [NamedType]? { nil }

    /// Get the interace's Swift code.
    /// - Parameters:
    ///   - name: The interface name.
    ///   - scalars: The equivalents to the scalars in Swift.
    ///   - enums: All of the enumerations in the document.
    ///   - objects: All of the objects in the document.
    /// - Returns: The code.
    func code(name: String, scalars: [String: String], enums: [String], objects: [ObjectTypeDefinition]) -> String {
        var unionMemberTypes: [NamedType] = []
        for object in objects {
            if let implementsInterfaces = object.implementsInterfaces,
               implementsInterfaces.contains(where: { $0.name == self.name }) {
                unionMemberTypes.append(.init(name: object.name))
            }
        }
        return UnionTypeDefinition(
            context: context,
            description: description,
            name: self.name,
            directives: directives,
            unionMemberTypes: unionMemberTypes
        ).code(name: name, scalars: scalars, enums: enums, objects: objects)
    }

}

// swiftlint:enable discouraged_optional_collection
