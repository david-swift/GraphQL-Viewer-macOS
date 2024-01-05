//
//  SidebarView.swift
//  GraphQL Viewer
//
//  Created by david-swift on 13.06.2023.
//

import SwiftUI

/// The sidebar view.
struct SidebarView: View {

    /// The view model.
    @EnvironmentObject var viewModel: ViewModel
    /// The document.
    var document: GraphQLDocument

    /// The view's body.
    var body: some View {
        List(selection: $viewModel.selection) {
            ForEach(Definition.allCases, id: \.hashValue) { definitionType in
                Section(definitionType.name.localized) {
                    ForEach(
                        definitionType.getDefinitions(definitions: document.document.definitions),
                        id: \.name
                    ) { definition in
                        Label(definition.name, systemSymbol: definitionType.icon)
                    }
                }
            }
        }
    }
}

#Preview {
    SidebarView(viewModel: .init(), document: .init())
}
