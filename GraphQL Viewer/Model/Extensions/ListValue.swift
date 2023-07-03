//
//  ListValue.swift
//  GraphQL Viewer
//
//  Created by david-swift on 19.06.2023.
//

import Foundation
import GraphQLLanguage

extension ListValue: ValueProtocol {

    /// A list value's textual description.
    var description: String? { values.description }

}
