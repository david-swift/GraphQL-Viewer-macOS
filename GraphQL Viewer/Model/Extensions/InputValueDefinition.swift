//
//  InputValueDefinition.swift
//  GraphQL Viewer
//
//  Created by david-swift on 23.06.2023.
//
// swiftlint:disable discouraged_optional_collection

import GraphQLLanguage

extension InputValueDefinition: Child {

    /// An input value definition has not got any arguments.
    var argumentsDefinition: [GraphQLLanguage.InputValueDefinition]? { nil }
    /// The input value's type.
    var type: GraphQLLanguage.TypeReference? { typeReference }
    /// The input value's description.
    var typeDescription: Description? { description }

}

// swiftlint:enable discouraged_optional_collection
