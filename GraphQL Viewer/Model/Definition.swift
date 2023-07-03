//
//  Definition.swift
//  GraphQL Viewer
//
//  Created by david-swift on 12.06.2023.
//

import Foundation
import GraphQLLanguage
import SFSafeSymbols

/// An enumeration containing all definition types.
enum Definition: CaseIterable {

    /// The query definition type.
    case queryDefinitions
    /// The mutation definition type.
    case mutationDefinitions
    /// The object definition type.
    case objectTypeDefinitions
    /// The input object definition type.
    case inputObjectTypeDefinitions
    /// The enumeration definition type.
    case enumTypeDefinitions
    /// The interface definition type.
    case interfaceTypeDefinitions
    /// The union definition type.
    case unionTypeDefinitions
    /// The scalar definition type.
    case scalarTypeDefinitions
    /// The directive definition type.
    case directiveDefinitions

    /// The definition's type as a type conforming to `GraphQLLanguage.Definition`.
    var type: GraphQLLanguage.Definition.Type {
        switch self {
        case .queryDefinitions, .mutationDefinitions, .objectTypeDefinitions:
            return ObjectTypeDefinition.self
        case .interfaceTypeDefinitions:
            return InterfaceTypeDefinition.self
        case .directiveDefinitions:
            return DirectiveDefinition.self
        case .inputObjectTypeDefinitions:
            return InputObjectTypeDefinition.self
        case .enumTypeDefinitions:
            return EnumTypeDefinition.self
        case .unionTypeDefinitions:
            return UnionTypeDefinition.self
        case .scalarTypeDefinitions:
            return ScalarTypeDefinition.self
        }
    }

    /// The localized description.
    var name: LocalizedStringResource {
        switch self {
        case .queryDefinitions:
            return .init("Queries", comment: "Definition (Queries name)")
        case .mutationDefinitions:
            return .init("Mutations", comment: "Definition (Mutations name)")
        case .objectTypeDefinitions:
            return .init("Objects", comment: "Definition (Objects name)")
        case .inputObjectTypeDefinitions:
            return .init("Input Objects", comment: "Definition (Input objects name)")
        case .enumTypeDefinitions:
            return .init("Enumerations", comment: "Definition (Enumerations name)")
        case .interfaceTypeDefinitions:
            return .init("Interfaces", comment: "Definition (Interfaces name)")
        case .unionTypeDefinitions:
            return .init("Unions", comment: "Definition (Unions name)")
        case .scalarTypeDefinitions:
            return .init("Scalars", comment: "Definition (Scalars name)")
        case .directiveDefinitions:
            return .init("Directives", comment: "Definition (Directives name)")
        }
    }

    /// An icon describing the definition type.
    var icon: SFSymbol {
        switch self {
        case .queryDefinitions:
            return .magnifyingglass
        case .mutationDefinitions:
            return .pencil
        case .objectTypeDefinitions:
            return .shippingbox
        case .inputObjectTypeDefinitions:
            return .characterTextbox
        case .enumTypeDefinitions:
            return .listBullet
        case .interfaceTypeDefinitions:
            return .puzzlepiece
        case .unionTypeDefinitions:
            return .arrowTriangleBranch
        case .scalarTypeDefinitions:
            return .number
        case .directiveDefinitions:
            return .arrowRight
        }
    }

    /// Filter the definitions to only get the definitions of one type.
    /// - Parameter definitions: The definitions.
    /// - Returns: The filtered definitions.
    func getDefinitions(definitions: [GraphQLLanguage.Definition]) -> [DefinitionProtocol] {
        var getDefinitions: [DefinitionProtocol] = []
        for definition in definitions {
            let type = Mirror(reflecting: definition).subjectType
            if type == self.type, let definition = definition as? DefinitionProtocol {
                if (definition.name == .queryType && self == .queryDefinitions)
                    || (definition.name == .mutationType && self == .mutationDefinitions) {
                    if let fields = definition.fieldsDefinition {
                        for field in fields {
                            getDefinitions.append(field)
                        }
                    }
                } else if definition.name != .queryType && definition.name != .mutationType
                  && self != .queryDefinitions && self != .mutationDefinitions {
                    getDefinitions.append(definition)
                }
            }
        }
        return getDefinitions
    }

}
