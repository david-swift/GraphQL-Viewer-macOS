//
//  GraphQLViewerApp.swift
//  GraphQL Viewer
//
//  Created by david-swift on 11.06.2023.
//

import PigeonApp
import SwiftUI

/// The GraphQL Viewer app.
@main
struct GraphQLViewerApp: App {

    /// The app model.
    var appModel = AppModel.shared

    /// The view's body.
    var body: some Scene {
        PigeonDocumentApp(
            appName: "GraphQL Viewer",
            appIcon: .init(nsImage: .init(named: "AppIcon") ?? .init()),
            document: GraphQLDocument()
        ) { $document, _, _, _ in
            ContentView(document: document)
                .environmentObject(appModel)
        }
        .information(description: .init(localized: .init(
            "A macOS app for viewing GraphQL schemas and generating GraphQL Swift packages.",
            comment: "GraphQLViewerApp (The app's description)"
        ))) {
            for link in appModel.links {
                (.init(localized: link.0), link.1)
            }
        } contributors: {
            for contributor in appModel.contributors {
                contributor
            }
        } acknowledgements: {
            ("GraphQLLanguage", .string("https://github.com/niw/GraphQLLanguage"))
            ("SwiftLintPlugin", .string("https://github.com/lukepistrol/SwiftLintPlugin"))
            ("MarkdownUI", .string("https://github.com/gonzalezreal/swift-markdown-ui"))
            ("PigeonApp", .string("https://github.com/david-swift/PigeonApp-macOS"))
        }
        .help(.init(
            "GraphQL Viewer Help",
            comment: "GraphQLViewerApp (Label of the help link)"
        ), link: .string("https://david-swift.gitbook.io/graphql-viewer/"))
        .newestVersion(gitHubUser: "david-swift", gitHubRepo: "GraphQL-Viewer-macOS")
        .versions {
            for version in appModel.versions { version }
        }
        .commands {
            GraphQLViewerCommands()
        }

    }
}
