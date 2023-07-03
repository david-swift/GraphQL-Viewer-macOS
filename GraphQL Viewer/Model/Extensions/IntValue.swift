//
//  IntValue.swift
//  GraphQL Viewer
//
//  Created by david-swift on 19.06.2023.
//

import Foundation
import GraphQLLanguage

extension IntValue: ValueProtocol {

    /// A integer's textual description.
    var description: String? { intValue.description }

}
