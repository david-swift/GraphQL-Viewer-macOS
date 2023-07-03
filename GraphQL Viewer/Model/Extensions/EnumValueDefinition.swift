//
//  EnumValueDefinition.swift
//  GraphQL Viewer
//
//  Created by david-swift on 24.06.2023.
//
// swiftlint:disable discouraged_optional_collection

import GraphQLLanguage

extension EnumValueDefinition: Child {

    /// The enum value's description.
    var typeDescription: Description? { description }
    /// The enum value's name.
    var name: String { enumValue.enumValue }
    /// An enum value does not have arguments.
    var argumentsDefinition: [InputValueDefinition]? { nil }
    /// An enum value does not have a return type.
    var type: GraphQLLanguage.TypeReference? { nil }
    /// An enum value does not have a default value.
    var defaultValue: GraphQLLanguage.Value? { nil }

}

// swiftlint:enable discouraged_optional_collection
