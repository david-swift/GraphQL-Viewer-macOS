//
//  Optional.swift
//  GraphQL Viewer
//
//  Created by david-swift on 28.06.2023.
//

import Foundation

extension Optional where Wrapped == String {

    /// An optional string's description.
    var description: String {
        self?.map { $0.isNewline ? " " : .init($0) }.joined() ?? "No Description"
    }

}
