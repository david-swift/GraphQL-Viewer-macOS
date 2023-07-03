//
//  TypeLinkView.swift
//  GraphQL Viewer
//
//  Created by david-swift on 18.06.2023.
//

import GraphQLLanguage
import SwiftUI

/// A view showing the link to a type.
struct TypeLinkView: View {

    /// The view model.
    @Environment(ViewModel.self)
    var viewModel
    /// Whether the link view is hovered.
    @State private var hover = false
    /// The document.
    var document: GraphQLDocument
    /// The type reference.
    var type: TypeReferenceProtocol
    /// Whether it is a directive location.
    var isDirectiveLocation = false

    /// The type's definition.
    var definition: (DefinitionProtocol, Definition)? {
        document.definitionSelection(selection: type.type)
    }
    /// Whether the type is a default type.
    var isDefaultType: Bool {
        DefaultType.allCases.map { $0.rawValue }.contains(type.type)
    }
    /// The type's accent color.
    var accentColor: Color {
        definition != nil ? .accentColor : ((isDefaultType || isDirectiveLocation) ? .orange : .red)
    }

    /// The vertical padding of the type link view.
    let verticalPadding = 10.0
    /// The opacity of the background when hovered.
    let hoverOpacity = 0.1

    /// The view's body.
    var body: some View {
        Button {
            viewModel.navigation.append(type.type)
        } label: {
            HStack {
                icon
                label
                Spacer()
                Image(systemSymbol: .chevronRight)
                    .foregroundStyle(accentColor)
                    .bold()
                    .accessibilityLabel(.init("Show Definition", comment: "TypeLinkView (Link accessibility label)"))
            }
            .padding(.horizontal)
            .padding(.vertical, verticalPadding)
            .background(
                .gray.opacity(hover ? hoverOpacity : 0),
                in: RoundedRectangle(cornerRadius: .colibriCornerRadius)
            )
            .onHover { hover = $0 }
        }
        .buttonStyle(.plain)
    }

    /// The icon on the left of the link view.
    private var icon: some View {
        Group {
            if let definition {
                Image(systemSymbol: definition.1.icon)
            } else if isDefaultType {
                Image(systemSymbol: .number)
            } else if isDirectiveLocation {
                Image(systemSymbol: .location)
            } else {
                Image(systemSymbol: .xmark)
            }
        }
        .accessibilityHidden(true)
        .bold()
        .foregroundStyle(accentColor)
    }

    /// The text in the link view.
    private var label: some View {
        VStack(alignment: .leading) {
            type.text(color: accentColor)
            if let definition {
                Text(definition.0.description?.stringValue.stringValue ?? .init())
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
            } else if isDefaultType {
                Text(.init("A default scalar type.", comment: "TypeLinkView (Default type description)"))
                    .foregroundStyle(.secondary)
            } else if isDirectiveLocation {
                Text(.init("A directive location.", comment: "TypeLinkView (Directive location description)"))
                    .foregroundStyle(.secondary)
            } else {
                Text(.init("Type not found.", comment: "TypeLinkView (Error description)"))
                    .foregroundStyle(accentColor)
            }
        }
    }

}
