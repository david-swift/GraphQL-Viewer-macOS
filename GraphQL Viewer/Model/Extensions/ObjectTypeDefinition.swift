//
//  ObjectTypeDefinition.swift
//  GraphQL Viewer
//
//  Created by david-swift on 12.06.2023.
//
// swiftlint:disable discouraged_optional_collection

import Foundation
import GraphQLLanguage

extension ObjectTypeDefinition: DefinitionProtocol {

    /// The object's return type is always nil.
    var type: TypeReference? { nil }
    /// The object's argument definition is always nil.
    var argumentsDefinition: [InputValueDefinition]? { nil }
    /// The object's directive locations are always empty.
    var directiveLocations: [DirectiveLocation] { [] }
    /// The object's enumeration value definition is always nil.
    var enumValuesDefinition: [EnumValueDefinition]? { nil }
    /// The object's union member types definition is always nil.
    var unionMemberTypes: [NamedType]? { nil }

    /// Get the code for an object.
    /// - Parameters:
    ///   - name: The type name.
    ///   - scalars: The scalars equivalents in Swift.
    ///   - enums: The enumeration definitions.
    ///   - objects: The object definitions.
    /// - Returns: A code.
    func code(name: String, scalars: [String: String], enums: [String], objects: [ObjectTypeDefinition]) -> String {
        code(name: name, scalars: scalars, enums: enums, objects: objects, initializer: false)
    }

    /// Get the code for an object or an input object.
    /// - Parameters:
    ///   - name: The type name.
    ///   - scalars: The scalars equivalents in Swift.
    ///   - enums: The enumeration definitions.
    ///   - objects: The object definitions.
    ///   - initializer: Whether an initializer is required (input object) or not.
    /// - Returns: The Swift code.
    func code(
        name: String,
        scalars: [String: String],
        enums: [String],
        objects: [ObjectTypeDefinition],
        initializer: Bool
    ) -> String {
        var code = ""

        // swiftlint:disable trailing_whitespace line_length
        code.append(
            """
            /// \((description?.stringValue.stringValue).description)
            @GraphQLObject
            public final class \(name) {
            
            """
        )

        if let fields = fieldsDefinition {
            for definition in fields {
                var wrappersDefinition = ""
                let typeString = definition.type?.reference.swiftType ?? "String"
                if scalars[typeString] != nil
                    || DefaultType.allCases.map({ $0.swift }).contains(typeString) || enums.contains(typeString) {
                    wrappersDefinition.append("@Value ")
                }
                if let arguments = definition.argumentsDefinition, !arguments.isEmpty {
                    wrappersDefinition.append("@Arguments([")
                    for argument in arguments {
                        wrappersDefinition.append(
                            "\"\(argument.name)\": \(argument.type?.reference.notOptionalDescription ?? "String")(), "
                        )
                    }
                    let commaSpaceCount = 2; wrappersDefinition.removeLast(commaSpaceCount)
                    wrappersDefinition.append("]) ")
                }
                var name = definition.name
                if ["private", "public", "operator", "extension", "class", "where"].contains(name) {
                    name = "`\(name)`"
                }
                code.append(
                """
                
                    /// \((definition.description?.stringValue.stringValue).description)
                    \(wrappersDefinition)public var \(name): \(definition.type?.reference.notOptionalDescription ?? "String")? = nil
                """
                )
            }
        }

        if initializer {
            code.append(
                """
                
                    /// An initializer for the input object type.
                    public init() { }
                """
            )
        }

        return code.appending("\n\n}")
        // swiftlint:enable trailing_whitespace line_length
    }

}

// swiftlint:enable discouraged_optional_collection
