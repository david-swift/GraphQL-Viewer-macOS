//
//  Variable.swift
//  GraphQL Viewer
//
//  Created by david-swift on 19.06.2023.
//

import Foundation
import GraphQLLanguage

extension Variable: ValueProtocol {

    /// A variable's textual description.
    var description: String? { name }

}
