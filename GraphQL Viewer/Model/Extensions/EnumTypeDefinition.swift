//
//  EnumTypeDefinition.swift
//  GraphQL Viewer
//
//  Created by david-swift on 12.06.2023.
//
// swiftlint:disable discouraged_optional_collection

import Foundation
import GraphQLLanguage

extension EnumTypeDefinition: DefinitionProtocol {

    /// An enumeration never implements interfaces.
    var implementsInterfaces: [NamedType]? { nil }
    /// An enumeration has no arguments.
    var argumentsDefinition: [InputValueDefinition]? { nil }
    /// An enumeration has no fields.
    var fieldsDefinition: [FieldDefinition]? { nil }
    /// An enumeration has no return type.
    var type: TypeReference? { nil }
    /// An enumeration has no directive locations.
    var directiveLocations: [DirectiveLocation] { [] }
    /// An enumeration has no union member types.
    var unionMemberTypes: [NamedType]? { nil }

    /// Get the Swift code for the enumeration definition.
    /// - Parameters:
    ///   - name: The type name.
    ///   - scalars: The document's scalars.
    ///   - enums: The document's enumerations.
    ///   - objects: The document's objects.
    /// - Returns: The code.
    func code(name: String, scalars: [String: String], enums: [String], objects: [ObjectTypeDefinition]) -> String {
        // swiftlint:disable trailing_whitespace
        var code = """
        /// \((description?.stringValue.stringValue).description)
        public enum \(name): String, Codable, GraphQLValueType {
        
        """
        if let enumValuesDefinition {
            for enumValue in enumValuesDefinition {
                code.append(
                """
                
                    /// \((enumValue.description?.stringValue.stringValue).description)
                    case \(enumValue.enumValue.enumValue)
                """
                )
            }
            code.append(
                """
                
                    /// A textual representation for GraphQL queries and mutations.
                    public var string: String { rawValue }
                """
            )
            if let first = enumValuesDefinition.first {
                code.append(
                    """
                    
                        /// The default initialization.
                        public init() {
                            self = .\(first.name)
                        }
                    """
                )
            }
        }
        code.append(
            """
            
            }
            """
        )
        return code
        // swiftlint:enable trailing_whitespace
    }

}

// swiftlint:enable discouraged_optional_collection
