//
//  SearchResultsView.swift
//  GraphQL Viewer
//
//  Created by david-swift on 24.06.2023.
//

import GraphQLLanguage
import SFSafeSymbols
import SwiftUI

/// A view showing the search results.
struct SearchResultsView: View {

    /// The view model.
    @EnvironmentObject var viewModel: ViewModel
    /// The document.
    var document: GraphQLDocument

    /// The filtered definitions.
    var filteredContent: [String] {
        (viewModel.searchScope?.getDefinitions(definitions: document.document.definitions)
         ?? document.document.definitions.compactMap { $0 as? DefinitionProtocol })
            .filter { definition in
                (definition.name.fuzzyMatch(viewModel.search)
                 || definition.description?.stringValue.stringValue.fuzzyMatch(viewModel.search) ?? false)
            }
            .map { $0.name }
    }

    /// The view's body.
    var body: some View {
        if filteredContent.isEmpty {
            let text = LocalizedStringResource(
                "No Search Results",
                comment: "SearchResultsView (No search results title)"
            )
            if #available(macOS 14.0, *) {
                ContentUnavailableView(String(localized: text), systemImage: SFSymbol.magnifyingglass.rawValue)
            } else {
                Text(text)
            }
            if viewModel.searchScope != nil {
                Button(.init("Remove Type Filter", comment: "SearchResultsView (No search result tip)")) {
                    viewModel.searchScope = nil
                }
            }
        } else {
            ScrollView {
                LazyVStack {
                    ForEach(filteredContent, id: \.self) { type in
                        TypeLinkView(document: document, type: NonNullType(typeReference: NamedType(name: type)))
                    }
                }
                .padding()
            }
        }
    }

}

#Preview {
    SearchResultsView(document: .init())
}
