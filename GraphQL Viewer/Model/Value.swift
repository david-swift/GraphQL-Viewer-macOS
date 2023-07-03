//
//  Value.swift
//  GraphQL Viewer
//
//  Created by david-swift on 18.06.2023.
//

import Foundation
import GraphQLLanguage
import SFSafeSymbols

/// An enumeration containing all the value types.
enum Value: CaseIterable {

    /// A variable.
    case variable
    /// An integer.
    case int
    /// A float.
    case float
    /// A boolean.
    case bool
    /// A string.
    case string
    /// Null.
    case null
    /// An enumeration value.
    case `enum`
    /// A list value.
    case list
    /// An object value.
    case object

    /// The value's type as a `GraphQLLanguage.Value`.
    var type: GraphQLLanguage.Value.Type {
        switch self {
        case .variable:
            return Variable.self
        case .int:
            return IntValue.self
        case .float:
            return FloatValue.self
        case .bool:
            return BooleanValue.self
        case .string:
            return StringValue.self
        case .null:
            return NullValue.self
        case .enum:
            return EnumValue.self
        case .list:
            return ListValue.self
        case .object:
            return ObjectValue.self
        }
    }

    /// The type's name.
    var name: LocalizedStringResource {
        switch self {
        case .variable:
            return .init("Variable", comment: "Value (Variable name)")
        case .int:
            return .init("Integer", comment: "Value (Integer name)")
        case .float:
            return .init("Float", comment: "Value (Float name)")
        case .bool:
            return .init("Boolean", comment: "Value (Boolean name)")
        case .string:
            return .init("String", comment: "Value (String name)")
        case .null:
            return .init("Null", comment: "Value (Null name)")
        case .enum:
            return .init("Enumeration", comment: "Value (Enumeration name)")
        case .list:
            return .init("List", comment: "Value (List name)")
        case .object:
            return .init("Object", comment: "Value (Object name)")
        }
    }

    /// The type's icon.
    var icon: SFSymbol {
        switch self {
        case .variable:
            return .function
        case .int, .float:
            return .number
        case .bool:
            return .circleLefthalfFilled
        case .string:
            return .textformat
        case .null:
            return .circle
        case .enum:
            return .listBullet
        case .list:
            return .rectangleStack
        case .object:
            return .shippingbox
        }
    }

}
