//
//  Child.swift
//  GraphQL Viewer
//
//  Created by david-swift on 23.06.2023.
//

// swiftlint:disable discouraged_optional_collection

import GraphQLLanguage

/// A type's child definition.
protocol Child {

    /// The child's description.
    var typeDescription: Description? { get }
    /// The child's name.
    var name: String { get }
    /// The child's arguments.
    var argumentsDefinition: [InputValueDefinition]? { get }
    /// The child's type.
    var type: TypeReference? { get }
    /// The child's directives.
    var directives: [Directive]? { get }
    /// The child's default value.
    var defaultValue: GraphQLLanguage.Value? { get }

}

// swiftlint:enable discouraged_optional_collection
