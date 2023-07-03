//
//  StringValue.swift
//  GraphQL Viewer
//
//  Created by david-swift on 19.06.2023.
//

import Foundation
import GraphQLLanguage

extension StringValue: ValueProtocol {

    /// The string.
    var description: String? { stringValue }

}
