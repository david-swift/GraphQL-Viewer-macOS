//
//  ChildrenView.swift
//  GraphQL Viewer
//
//  Created by david-swift on 23.06.2023.
//

import GraphQLLanguage
import MarkdownUI
import SwiftUI

/// A view showing children of a type.
struct ChildrenView: View {

    /// The children.
    var children: [Child]
    /// The document.
    var document: GraphQLDocument

    /// The view's body.
    var body: some View {
        ForEach(children, id: \.name) { child in
            VStack(alignment: .leading) {
                if let directives = child.directives {
                    DirectivesView(directives: directives, document: document)
                }
                if let arguments = child.argumentsDefinition {
                    Self(children: arguments, document: document)
                }
                if let defaultValue = (child.defaultValue as? ValueProtocol)?.description {
                    Text("**\(child.name):** \(defaultValue)")
                } else {
                    Text(child.name)
                        .bold()
                }
                if let description = child.typeDescription?.stringValue.stringValue
                    .trimmingCharacters(in: .whitespaces) {
                    Markdown(.init(description))
                }
                if let type = child.type as? TypeReferenceProtocol {
                    TypeLinkView(document: document, type: type)
                }
            }
            .graphQLViewerGroup()
        }
    }
}

#Preview {
    ChildrenView(children: [], document: .init())
}
