//
//  FieldDefinition.swift
//  GraphQL Viewer
//
//  Created by david-swift on 12.06.2023.
//
// swiftlint:disable discouraged_optional_collection

import Foundation
import GraphQLLanguage

extension FieldDefinition: DefinitionProtocol, Child {

    /// The definition's description.
    var typeDescription: Description? { description }
    /// A field cannot implement interfaces, so it is nil.
    var implementsInterfaces: [NamedType]? { nil }
    /// A field's fields definition is always nil.
    var fieldsDefinition: [FieldDefinition]? { nil }
    /// The field's type.
    var type: TypeReference? { typeReference }
    /// A field's directive locations definition is always empty.
    var directiveLocations: [DirectiveLocation] { [] }
    /// A field cannot have enum cases, so this is always nil.
    var enumValuesDefinition: [EnumValueDefinition]? { nil }
    /// A field cannot have a default value. This always returns nil.
    var defaultValue: GraphQLLanguage.Value? { nil }
    /// A field cannot have union member types. This always returns nil.
    var unionMemberTypes: [NamedType]? { nil }

    /// The Swift code for the field definition (either query or mutation).
    /// - Parameters:
    ///   - name: The type name.
    ///   - scalars: The document's scalars.
    ///   - enums: The document's enumerations.
    ///   - objects: The document's objects.
    /// - Returns: The code.
    func code(name: String, scalars: [String: String], enums: [String], objects: [ObjectTypeDefinition]) -> String {
        // swiftlint:disable trailing_whitespace
        var code: String
        if name.hasSuffix("Mutation") {
            code = """
            /// \((description?.stringValue.stringValue).description)
            @GraphQLMutation
            public struct \(name) {
            
                /// The mutation's name.
                public static var query: String { "\(self.name)" }
            """
        } else {
            code = """
            /// \((description?.stringValue.stringValue).description)
            @GraphQLQuery
            public struct \(name) {
            
                /// The query's name.
                public static var query: String { "\(self.name)" }
            """
        }
        if let argumentsDefinition {
            for argument in argumentsDefinition {
                code.append("""
                
                    /// \((argument.description?.stringValue.stringValue).description)
                    public var \(argument.name): \(argument.type?.reference.description ?? "String")
                """)
            }
        }
        code.append("""
        
            /// The fields.
            public var fields: \(typeReference.reference.swiftType).Fields
        
        }
        """)
        return code
        // swiftlint:enable trailing_whitespace
    }

}

// swiftlint:enable discouraged_optional_collection
