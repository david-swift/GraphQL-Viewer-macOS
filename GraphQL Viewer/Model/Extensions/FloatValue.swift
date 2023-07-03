//
//  FloatValue.swift
//  GraphQL Viewer
//
//  Created by david-swift on 19.06.2023.
//

import Foundation
import GraphQLLanguage

extension FloatValue: ValueProtocol {

    /// A float's textual description.
    var description: String? { floatValue.description }

}
