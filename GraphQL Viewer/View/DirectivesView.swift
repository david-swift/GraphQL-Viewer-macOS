//
//  DirectivesView.swift
//  GraphQL Viewer
//
//  Created by david-swift on 19.06.2023.
//

import GraphQLLanguage
import SwiftUI

/// A view showing an array of directives.
struct DirectivesView: View {

    /// The directives.
    var directives: [Directive]
    /// The document.
    var document: GraphQLDocument

    /// The view's body.
    var body: some View {
        ForEach(directives, id: \.name) { directive in
            VStack(alignment: .leading) {
                TypeLinkView(document: document, type: NonNullType(typeReference: NamedType(name: directive.name)))
                ForEach(directive.arguments ?? [], id: \.name) { argument in
                    if let value = (argument.value as? ValueProtocol)?.description {
                        Text("**\(argument.name):** \(value)")
                    }
                }
            }
            .graphQLViewerGroup(enabled: !(directive.arguments?.isEmpty ?? true))
        }
    }

}

#Preview {
    DirectivesView(directives: [], document: .init())
}
