//
//  DirectiveDefinition.swift
//  GraphQL Viewer
//
//  Created by david-swift on 12.06.2023.
//
// swiftlint:disable discouraged_optional_collection string_literals

import Foundation
import GraphQLLanguage

extension DirectiveDefinition: DefinitionProtocol {

    /// A directive definition implements no interfaces.
    var implementsInterfaces: [NamedType]? { nil }
    /// A directive definition implements no directives.
    var directives: [Directive]? { nil }
    /// A directive definition has not got any fields.
    var fieldsDefinition: [FieldDefinition]? { nil }
    /// A directive definition's return type is always nil.
    var type: TypeReference? { nil }
    /// A directive definition's enumeration cases are always empty.
    var enumValuesDefinition: [EnumValueDefinition]? { nil }
    /// A directive definition's union member types are always nil.
    var unionMemberTypes: [NamedType]? { nil }

    /// The Swift code of the directive definition is always empty,
    /// as directives are not implemented in Swift.
    /// - Parameters:
    ///   - name: The directive's name.
    ///   - scalars: The doument's scalars.
    ///   - enums: The document's enumerations.
    ///   - objects: The document's objects.
    /// - Returns: The code.
    func code(name: String, scalars: [String: String], enums: [String], objects: [ObjectTypeDefinition]) -> String {
        """
        """
    }

}

// swiftlint:enable discouraged_optional_collection string_literals
