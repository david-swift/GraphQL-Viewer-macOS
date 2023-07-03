//
//  GraphQLViewerCommands.swift
//  GraphQL Viewer
//
//  Created by david-swift on 01.07.2023.
//

import SwiftUI

/// Commands for the GraphQL Viewer app.
struct GraphQLViewerCommands: Commands {

    /// The active view model.
    @FocusedObject private var viewModel: ViewModel?
    /// The active document.
    @FocusedValue(\.document)
    var document

    /// The view's body.
    var body: some Commands {
        SidebarCommands()
        CommandGroup(after: .newItem) {
            Divider()
            Button(.init("Navigate Back", comment: "GraphQLViewerCommands (Button for navigating back)")) {
                viewModel?.back()
            }
            .keyboardShortcut("ö")
            Divider()
        }
        CommandGroup(replacing: .importExport) {
            Button(.init(
                "Export as Swift Package",
                comment: "GraphQLViewerCommands (Button for exporting as Swift package)"
            )) {
                if let document {
                    viewModel?.export(document: document)
                }
            }
            .keyboardShortcut("e")
        }
    }

}
