//
//  TypeReference.swift
//  GraphQL Viewer
//
//  Created by david-swift on 28.06.2023.
//

import Foundation
import GraphQLLanguage

extension TypeReference {

    /// The type reference as a type conforming to the type reference protocol.
    var reference: TypeReferenceProtocol {
        self as? TypeReferenceProtocol ?? NamedType(name: .stringType)
    }

}
