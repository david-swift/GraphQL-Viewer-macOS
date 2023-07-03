//
//  String.swift
//  GraphQL Viewer
//
//  Created by david-swift on 12.06.2023.
//
//  Thanks to Chris Eidhof for the article:
//  "A Fast Fuzzy Search Implementation"
//  https://www.objc.io/blog/2020/08/18/fuzzy-search/ (18.08.20)
//

import Foundation

extension String {

    /// The object's name containing the queries as fields.
    static var queryType: Self { "Query" }
    /// The object's name containing the mutations as fields.
    static var mutationType: Self { "Mutation" }
    /// The GitHub repository of the GraphQL Viewer app.
    static var gitHubRepo: String { "https://github.com/david-swift/GraphQL-Viewer-macOS" }
    /// The URL to a new issue for a feature request.
    static var featureRequest: String {
        gitHubRepo
        + "/issues/new?assignees=&labels=enhancement&template=feature_request.yml"
    }
    /// The URL to a new issue for a bug report.
    static var bugReport: String {
        gitHubRepo
        + "/issues/new?assignees=&labels=bug&template=bug_report.yml"
    }
    /// The string type.
    static var stringType: Self { "String" }

    /// Checks whether a string matches a search string.
    /// Thanks to Chris Eidhof for the article "A Fast Fuzzy Search Implementation"
    /// - Parameter needle: The search string.
    /// - Returns: Whether the string matches the search string.
    func fuzzyMatch(_ needle: String) -> Bool {
        let `self` = self.lowercased().filter { !$0.isWhitespace }
        let needle = needle.lowercased().filter { !$0.isWhitespace }
        if needle.isEmpty {
            return true
        }
        var remainder = needle[...]
        for char in self where char == remainder[remainder.startIndex] {
            remainder.removeFirst()
            if remainder.isEmpty {
                return true
            }
        }
        return false
    }

}
