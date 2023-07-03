//
//  EnumValue.swift
//  GraphQL Viewer
//
//  Created by david-swift on 19.06.2023.
//

import Foundation
import GraphQLLanguage

extension EnumValue: ValueProtocol {

    /// An enumeration case's textual description.
    var description: String? { enumValue }

}
