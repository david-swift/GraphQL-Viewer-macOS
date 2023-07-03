//
//  NullValue.swift
//  GraphQL Viewer
//
//  Created by david-swift on 19.06.2023.
//

import Foundation
import GraphQLLanguage

extension NullValue: ValueProtocol {

    /// Always returns "null".
    var description: String? { "null" }

}
