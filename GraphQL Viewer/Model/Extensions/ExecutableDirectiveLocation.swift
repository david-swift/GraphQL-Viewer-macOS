//
//  ExecutableDirectiveLocation.swift
//  GraphQL Viewer
//
//  Created by david-swift on 24.06.2023.
//

import GraphQLLanguage

extension ExecutableDirectiveLocation: CustomStringConvertible {

    /// A textual representation of a directive location.
    public var description: String { rawValue }

}
