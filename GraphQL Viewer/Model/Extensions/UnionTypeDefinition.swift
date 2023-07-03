//
//  UnionTypeDefinition.swift
//  GraphQL Viewer
//
//  Created by david-swift on 24.06.2023.
//
// swiftlint:disable discouraged_optional_collection

import GraphQLLanguage

extension UnionTypeDefinition: DefinitionProtocol {

    /// A union type definition has not got any interfaces.
    var implementsInterfaces: [GraphQLLanguage.NamedType]? { nil }
    /// A union type definition has not got any arguments.
    var argumentsDefinition: [GraphQLLanguage.InputValueDefinition]? { nil }
    /// A union type definition has not got any fields.
    var fieldsDefinition: [GraphQLLanguage.FieldDefinition]? { nil }
    /// A union type's return type is always nil.
    var type: GraphQLLanguage.TypeReference? { nil }
    /// A union type has not got any directives.
    var directiveLocations: [GraphQLLanguage.DirectiveLocation] { [] }
    /// A union type has not got any enumeration cases.
    var enumValuesDefinition: [GraphQLLanguage.EnumValueDefinition]? { nil }

    /// The Swift code for the union type.
    /// - Parameters:
    ///   - name: The type's name.
    ///   - scalars: The document's scalars.
    ///   - enums: The document's enumerations.
    ///   - objects: The document's objects.
    /// - Returns: The code.
    func code(name: String, scalars: [String: String], enums: [String], objects: [ObjectTypeDefinition]) -> String {
        var fieldsDefinition: [FieldDefinition] = []
        if let unionMemberTypes {
            for object in objects where unionMemberTypes.contains(where: { $0.name == object.name }) {
                if let fields = object.fieldsDefinition {
                    fieldsDefinition += fields
                }
            }
        }
        for definition in fieldsDefinition {
            let definitions = fieldsDefinition.filter { $0.name == definition.name }
            var type = definitions.first?.type ?? NamedType(name: "String")
            for definition in definitions where definition.type?.reference.description != type.reference.description {
                type = NamedType(name: "String")
            }
            if let definition = definitions.first {
                let definition = FieldDefinition(
                    context: definition.context,
                    description: definition.description,
                    name: definition.name,
                    argumentsDefinition: definition.argumentsDefinition,
                    typeReference: type,
                    directives: definition.directives
                )
                fieldsDefinition = fieldsDefinition.filter { $0.name != definition.name }
                fieldsDefinition.append(definition)
            }
        }
        let object = ObjectTypeDefinition(
            context: context,
            description: description,
            name: self.name,
            implementsInterfaces: implementsInterfaces,
            directives: directives,
            fieldsDefinition: fieldsDefinition
        )
        return object.code(name: name, scalars: scalars, enums: enums, objects: objects)
    }

}

// swiftlint:enable discouraged_optional_collection
