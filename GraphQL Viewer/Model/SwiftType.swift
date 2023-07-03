//
//  SwiftType.swift
//  GraphQL Viewer
//
//  Created by david-swift on 29.06.2023.
//

import ColibriComponents
import Foundation

/// The standard Swift types for booleans.
enum SwiftType: String, CaseIterable, Hashable, ColibriComponents.Bindable {

    /// The boolean type.
    case bool = "Bool"
    /// The double (Float64) type.
    case double = "Double"
    /// The integer type.
    case int = "Int"
    /// The string type.
    case string = "String"
    /// The URL type.
    case url = "URL"

}
