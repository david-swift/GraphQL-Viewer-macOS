//
//  BooleanValue.swift
//  GraphQL Viewer
//
//  Created by david-swift on 19.06.2023.
//

import Foundation
import GraphQLLanguage

extension BooleanValue: ValueProtocol {

    /// A boolean's textual description.
    var description: String? { booleanValue.description }

}
