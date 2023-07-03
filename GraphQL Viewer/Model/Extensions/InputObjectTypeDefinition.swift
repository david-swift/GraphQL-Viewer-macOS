//
//  InputObjectTypeDefinition.swift
//  GraphQL Viewer
//
//  Created by david-swift on 12.06.2023.
//
// swiftlint:disable discouraged_optional_collection

import Foundation
import GraphQLLanguage

extension InputObjectTypeDefinition: DefinitionProtocol {

    /// An input object implements no interfaces.
    var implementsInterfaces: [NamedType]? { nil }
    /// An input object's argument definition are the fields.
    var argumentsDefinition: [InputValueDefinition]? { inputFieldsDefinition }
    /// An input object's fields definition is always nil.
    var fieldsDefinition: [FieldDefinition]? { nil }
    /// An input object's return type is always nil.
    var type: TypeReference? { nil }
    /// An input object's directive locations are always empty.
    var directiveLocations: [DirectiveLocation] { [] }
    /// An input object's enumeration value definitions are always nil.
    var enumValuesDefinition: [EnumValueDefinition]? { nil }
    /// An input object's union member types are always nil.
    var unionMemberTypes: [NamedType]? { nil }

    /// The input object as a Swift code.
    /// - Parameters:
    ///   - name: The input object's name.
    ///   - scalars: The document's scalars.
    ///   - enums: The document's enumerations.
    ///   - objects: The document's objects.
    /// - Returns: The code.
    func code(name: String, scalars: [String: String], enums: [String], objects: [ObjectTypeDefinition]) -> String {
        ObjectTypeDefinition(
            context: context,
            description: description,
            name: self.name,
            implementsInterfaces: implementsInterfaces,
            directives: directives,
            fieldsDefinition: inputFieldsDefinition?.map { inputField in
                .init(
                    context: inputField.context,
                    description: inputField.description,
                    name: inputField.name,
                    argumentsDefinition: inputField.argumentsDefinition,
                    typeReference: inputField.typeReference,
                    directives: inputField.directives
                )
            } ?? []
        )
        .code(name: name, scalars: scalars, enums: enums, objects: objects, initializer: true)
    }

}

// swiftlint:enable discouraged_optional_collection
