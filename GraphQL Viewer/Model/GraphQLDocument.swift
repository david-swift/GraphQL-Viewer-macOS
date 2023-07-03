//
//  GraphQLDocument.swift
//  GraphQL Viewer
//
//  Created by david-swift on 11.06.2023.
//

import GraphQLLanguage
import SwiftUI
import UniformTypeIdentifiers

/// The GraphQL document.
struct GraphQLDocument: FileDocument {

    /// The readable content types.
    static var readableContentTypes: [UTType] { [.init(importedAs: "ch.david-swift.GraphQL")] }

    /// The document.
    var document: Document

    /// The file manager.
    let fileManager = FileManager.default

    /// Initialize a document from a read configuration.
    /// - Parameter configuration: The configuration.
    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents, let string = String(data: data, encoding: .utf8) else {
            throw CocoaError(.fileReadCorruptFile)
        }
        let source = Source(string: string)
        document = try .parsing(source)
    }

    /// Initialize an example document.
    init() {
        document = .init(definitions: [
            ObjectTypeDefinition(
                description: .init(stringValue: .init(stringValue: "A test object.")),
                name: "TestObject",
                implementsInterfaces: [.init(name: "Interface")],
                directives: [.init(name: "directive")],
                fieldsDefinition: [
                    .init(name: "example", typeReference: NamedType(name: "TestObject")),
                    .init(
                        description: .init(stringValue: .init(stringValue: "Cool")),
                        name: "cool",
                        argumentsDefinition: [
                            .init(name: "nice", typeReference: NonNullType(typeReference: NamedType(name: "String")))
                        ],
                        typeReference: NamedType(name: "String")
                    )
                ]
            ),
            ObjectTypeDefinition(
                name: "Query",
                fieldsDefinition: [.init(name: "exampleQuery", typeReference: NamedType(name: "String"))]
            ),
            InterfaceTypeDefinition(
                description: .init(stringValue: .init(stringValue: "The interface's description")),
                name: "Interface",
                fieldsDefinition: [.init(name: "example", typeReference: NamedType(name: "TestObject"))]
            ),
            DirectiveDefinition(
                description: .init(stringValue: .init(stringValue: "Some Directive")),
                name: "directive",
                directiveLocations: [TypeSystemDirectiveLocation.interface]
            ),
            InputObjectTypeDefinition(
                description: .init(stringValue: .init(stringValue: "A test input")),
                name: "Input",
                inputFieldsDefinition: [
                    .init(
                        description: .init(stringValue: .init(stringValue: "Nice Description")),
                        name: "hi",
                        typeReference: NamedType(name: "String")
                    )
                ]
            ),
            ScalarTypeDefinition(description: .init(stringValue: .init(stringValue: "String")), name: "String")
        ])
    }

    /// An error that occurs while working with the document.
    enum DocumentError: Error {

        /// An error.
        case error

    }

    /// Saving the file always throws an error.
    /// - Parameter configuration: The write configuration.
    /// - Returns: A file (but the function always fails).
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        throw DocumentError.error
    }

    /// Get the active definition selection and its type.
    /// - Parameter selection: The selection's name.
    /// - Returns: The type and definition.
    func definitionSelection(selection: String) -> (DefinitionProtocol, Definition)? {
       for definition in Definition.allCases {
            for element in definition.getDefinitions(
                definitions: document.definitions
            ) where element.name == selection {
                return (element, definition)
            }
        }
        return nil
    }

}
