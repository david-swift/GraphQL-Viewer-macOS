//
//  GraphQLViewerToolbar.swift
//  GraphQL Viewer
//
//  Created by david-swift on 18.06.2023.
//

import SwiftUI

/// The toolbar of the main window.
struct GraphQLViewerToolbar: CustomizableToolbarContent {

    /// The model of the active window.
    @EnvironmentObject var viewModel: ViewModel
    /// The selected document.
    var document: GraphQLDocument

    /// The navigation layer.
    var count: Int {
        viewModel.navigation.count
    }

    /// The toolbar body.
    var body: some CustomizableToolbarContent {
        ToolbarItem(id: "navigate-back", placement: .navigation) {
            Button {
                viewModel.back()
            } label: {
                HStack {
                    Image(systemSymbol: .chevronLeft)
                    Group {
                        if count >= 1 {
                            let secondLastOffsetToCount = -2
                            Text(viewModel.navigation[safe: count + secondLastOffsetToCount] ?? .init(
                                localized: .init(
                                    "No Selection",
                                    comment: "GraphQLViewerToolbar (No selection description)"
                                )
                            ))
                        }
                    }
                }
            }
            .disabled(count < 1)
        }
        ToolbarItem(id: "swift") {
            Button {
                viewModel.export(document: document)
            } label: {
                Label(.init(
                    "Save as Swift Package",
                    comment: "GraphQLViewerToolbar (Export label)"
                ), systemSymbol: .swift)
            }
        }
    }

}
