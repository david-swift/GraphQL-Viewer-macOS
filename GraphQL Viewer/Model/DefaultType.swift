//
//  DefaultType.swift
//  GraphQL Viewer
//
//  Created by david-swift on 22.06.2023.
//

import Foundation

/// The GraphQL default scalars.
enum DefaultType: String, CaseIterable {

    /// The integer scalar.
    case int = "Int"
    /// The float scalar.
    case float = "Float"
    /// The string scalar.
    case string = "String"
    /// The boolean scalar.
    case bool = "Boolean"
    /// The ID scalar.
    case id = "ID"

    /// The type's equivalent in Swift.
    var swift: String {
        switch self {
        case .float:
            return "Double"
        case .bool:
            return "Bool"
        case .id:
            return "String"
        default:
            return rawValue
        }
    }

}
