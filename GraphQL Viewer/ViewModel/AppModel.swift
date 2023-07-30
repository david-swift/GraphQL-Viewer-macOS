//
//  AppModel.swift
//  GraphQL Viewer
//
//  Created by david-swift on 11.06.2023.
//

import ColibriComponents
import Foundation
import PigeonApp
import SwiftUI

/// The model that stores data that affects all of the windows.
class AppModel: ObservableObject {

    /// A shared instance of ``AppModel``.
    static var shared = AppModel()
    /// A list of all of the contributors.
    @Published var contributors: [(String, URL)] = []

    /// Important links.
    let links: [(LocalizedStringResource, URL)] = [
        (
            .init("GitHub", comment: "AppModel (Label of the link to the GitHub repository)"),
            .string(.gitHubRepo)
        ),
        (
            .init("Bug Report", comment: "AppModel (Label of the link to the bug report issue)"),
            .string(.bugReport)
        ),
        (
            .init("Feature Request", comment: "AppModel (Label of the link to the feature request issue)"),
            .string(.featureRequest)
        )
    ]

    // swiftlint:disable no_magic_numbers
    /// The app's versions.
    @ArrayBuilder<Version> var versions: [Version] {
        Version("0.1.1", date: .init(timeIntervalSince1970: 1_690_694_644)) {
            Version.Feature(.init(
                "Support for macOS 13",
                comment: "AppModel (Feature in version 0.1.1)"
            ), description: .init(
                "The app now supports macOS 13 or later.",
                comment: "AppModel (Description of feature in version 0.1.1)"
            ), icon: .laptopcomputer)
        }
        Version("0.1.0", date: .init(timeIntervalSince1970: 1_688_226_031)) {
            Version.Feature(.init(
                "Initial Release",
                comment: "AppModel (Feature in version 0.1.0)"
            ), description: .init(
                "The first release of the GraphQL Viewer app.",
                comment: "AppModel (Description of feature in version 0.1.0)"
            ), icon: .partyPopper)
        }
    }
    // swiftlint:enable no_magic_numbers

    /// Initialize a new app model.
    init() {
        getContributors()
    }

    /// Get the contributors from the Contributors.md file.
    private func getContributors() {
        let regex = /- \[(?<name>.+?)]\((?<link>.+?)\)/
        do {
            if let path = Bundle.main.path(forResource: "Contributors", ofType: "md") {
                let lines: [String] = try String(contentsOfFile: path).components(separatedBy: "\n")
                for line in lines where line.hasPrefix("- ") {
                    if let result = try? regex.wholeMatch(in: line), let url = URL(string: .init(result.output.link)) {
                        contributors.append((.init(result.output.name), url))
                    }
                }
            }
        } catch { }
    }

}
