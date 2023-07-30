//
//  ContentView.swift
//  GraphQL Viewer
//
//  Created by david-swift on 11.06.2023.
//

import ColibriComponents
import SwiftUI

/// The main window.
struct ContentView: View {

    /// The selected document.
    var document: GraphQLDocument
    /// The view model.
    @StateObject private var viewModel = ViewModel()

    /// The view's body.
    var body: some View {
        NavigationSplitView {
            SidebarView(document: document)
        } detail: {
            if !viewModel.search.isEmpty {
                SearchResultsView(document: document)
            } else {
                DetailView(navigation: $viewModel.navigation, document: document)
            }
        }
        .toolbar(id: "detail") {
            GraphQLViewerToolbar(document: document)
        }
        .searchable(text: $viewModel.search)
        .searchScopes($viewModel.searchScope) {
            Text(.init("All", comment: "ContentView (All search scope)"))
                .tag(nil as Definition?)
            ForEach(Definition.allCases, id: \.hashValue) { definition in
                Text(definition.name)
                    .tag(definition as Definition?)
            }
        }
        .sheet(isPresented: $viewModel.export) {
            ExportView(document: document)
        }
        .environmentObject(viewModel)
        .markdownTheme(.docC)
        .focusedValue(\.document, document)
        .focusedObject(viewModel)
    }

}

#Preview {
    ContentView(document: .init())
        .environmentObject(AppModel())
}
