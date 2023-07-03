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
    @State var viewModel = ViewModel()

    /// The view's body.
    var body: some View {
        NavigationSplitView(columnVisibility: .init {
            viewModel.isPresented ? .detailOnly : .all
        } set: { newValue in
            withAnimation {
                if newValue == .detailOnly {
                    viewModel.isPresented = true
                } else {
                    viewModel.isPresented = false
                }
            }
        }) {
            SidebarView(viewModel: viewModel, document: document)
        } detail: {
            if viewModel.isPresented {
                SearchResultsView(document: document)
            } else {
                DetailView(navigation: $viewModel.navigation, document: document)
            }
        }
        .toolbar(id: "detail") {
            GraphQLViewerToolbar(document: document)
        }
        .searchable(text: $viewModel.search, isPresented: $viewModel.isPresented.animation())
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
        .environment(viewModel)
        .markdownTheme(.docC)
        .onChange(of: viewModel.navigation) { _, _ in
            viewModel.isPresented = false
        }
        .focusedValue(\.document, document)
        .focusedObject(viewModel)
    }

}

#Preview {
    ContentView(document: .init())
        .environment(AppModel())
}
