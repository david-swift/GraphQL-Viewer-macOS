//
//  ItemView.swift
//  GraphQL Viewer
//
//  Created by david-swift on 16.06.2023.
//

import GraphQLLanguage
import MarkdownUI
import SFSafeSymbols
import SwiftUI

/// A view showing information about a definition.
struct ItemView: View {

    /// The view model.
    @Environment(ViewModel.self)
    var viewModel
    /// The selected definition.
    var selection: String
    /// The document.
    var document: GraphQLDocument

    /// The padding inside the scroll view.
    let padding = 50.0
    /// The font size of the definition type information.
    let typeFontSize = 20.0

    /// The view's body.
    var body: some View {
        if let definitionSelection = document.definitionSelection(selection: selection) {
            ScrollView {
                LazyVStack {
                    HStack {
                        Spacer()
                        VStack(alignment: .leading) {
                            header(definitionSelection: definitionSelection)
                            Divider()
                                .padding(.vertical)
                            content1(definitionSelection: definitionSelection)
                            directivesContent(definitionSelection: definitionSelection)
                            if let cases = definitionSelection.0.enumValuesDefinition {
                                Text(.init("Enum Cases", comment: "ItemView (Enum cases section header)"))
                                    .sectionTitle()
                                ChildrenView(children: cases, document: document)
                            }
                            if let types = definitionSelection.0.unionMemberTypes {
                                Text(.init("Union Member Types", comment: "ItemView (Enum cases section header)"))
                                    .sectionTitle()
                                ForEach(types, id: \.name) { type in
                                    TypeLinkView(document: document, type: type)
                                }
                            }
                        }
                        .textSelection(.enabled)
                        Spacer()
                    }
                    .padding(padding)
                }
            }
            .id(selection)
        } else {
            ContentUnavailableView(
                String(localized: .init(
                    "Type Not Found",
                    comment: "ItemView (Type not found comment)"
                )),
                systemImage: SFSymbol.questionmarkCircle.rawValue,
                description: .init(.init(
                    "The type definition for \"\(selection)\" could not be found.",
                    comment: "ItemView (Type not found description)"
                ))
            )
        }
    }

    /// The definition type, name, description and return type.
    /// - Parameter definitionSelection: The definition.
    /// - Returns: A view containing the information.
    @ViewBuilder
    private func header(definitionSelection: (DefinitionProtocol, Definition)) -> some View {
        Text(definitionSelection.1.name)
            .foregroundStyle(.secondary)
            .font(.system(size: typeFontSize))
            .fontWeight(.semibold)
        Text(definitionSelection.0.name)
            .sectionTitle()
        if let description = definitionSelection.0.stringDescription {
            Markdown(.init(description))
        }
        if let type = definitionSelection.0.type as? TypeReferenceProtocol {
            TypeLinkView(document: document, type: type)
        }
    }

    /// The arguments and fields definition information.
    /// - Parameter definitionSelection: The definition.
    /// - Returns: A view containing the information.
    @ViewBuilder
    private func content1(definitionSelection: (DefinitionProtocol, Definition)) -> some View {
        if let arguments = definitionSelection.0.argumentsDefinition {
            Text(.init("Arguments", comment: "ItemView (Arumgents section header)"))
                .sectionTitle()
            ChildrenView(children: arguments, document: document)
        }
        if let fields = definitionSelection.0.fieldsDefinition {
            Text(.init("Fields", comment: "ItemView (Fields section header)"))
                .sectionTitle()
            ChildrenView(children: fields, document: document)
        }
        if let interfaces = definitionSelection.0.stringImplementsInterfaces {
            Text(.init("Interfaces", comment: "ItemView (Interfaces section header)"))
                .sectionTitle()
            ForEach(interfaces, id: \.self) { interface in
                TypeLinkView(document: document, type: NonNullType(typeReference: NamedType(name: interface)))
            }
        }
    }

    /// The directives and directive locations information.
    /// - Parameter definitionSelection: The definition.
    /// - Returns: A view containing the information.
    @ViewBuilder
    private func directivesContent(definitionSelection: (DefinitionProtocol, Definition)) -> some View {
        if let directives = definitionSelection.0.directives {
            Text(.init("Directives", comment: "ItemView (Directives section header)"))
                .sectionTitle()
            DirectivesView(directives: directives, document: document)
        }
        if !definitionSelection.0.directiveLocations.isEmpty,
           let definitions = definitionSelection.0.directiveLocations as? [CustomStringConvertible] {
            Text(.init("Directive Locations", comment: "ItemView (Directive locations section header)"))
                .sectionTitle()
            ForEach(definitions, id: \.description) { location in
                TypeLinkView(
                    document: document,
                    type: NonNullType(typeReference: NamedType(name: location.description)),
                    isDirectiveLocation: true
                )
            }
        }
    }

}

#Preview {
    ItemView(selection: "TestObject", document: .init())
}
