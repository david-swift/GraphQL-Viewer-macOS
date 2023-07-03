//
//  ObjectValue.swift
//  GraphQL Viewer
//
//  Created by david-swift on 19.06.2023.
//

import Foundation
import GraphQLLanguage

extension ObjectValue: ValueProtocol {

    /// An object value's textual description.
    var description: String? { sourceString }

}
