//
//  ValueProtocol.swift
//  GraphQL Viewer
//
//  Created by david-swift on 19.06.2023.
//

import Foundation
import GraphQLLanguage

/// A protocol for the values.
protocol ValueProtocol {

    /// A textual representation of the value.
    var description: String? { get }

}
