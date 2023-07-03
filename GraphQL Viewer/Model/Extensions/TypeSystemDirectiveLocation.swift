//
//  TypeSystemDirectiveLocation.swift
//  GraphQL Viewer
//
//  Created by david-swift on 24.06.2023.
//

import GraphQLLanguage

extension TypeSystemDirectiveLocation: CustomStringConvertible {

    /// A textual representation for a directive location.
    public var description: String { rawValue }

}
