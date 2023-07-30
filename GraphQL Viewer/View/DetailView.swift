//
//  DetailView.swift
//  GraphQL Viewer
//
//  Created by david-swift on 13.06.2023.
//

import SFSafeSymbols
import SwiftUI

/// The window's detail view.
struct DetailView: View {

    /// The navigation path.
    @Binding var navigation: [String]
    /// The active document.
    var document: GraphQLDocument

    /// The view's body.
    var body: some View {
        if let value = navigation.last {
            ItemView(selection: value, document: document)
        } else {
            let text = LocalizedStringResource(
                "No Selection",
                comment: "DetailView (No selection title)"
            )
            if #available(macOS 14.0, *) {
                ContentUnavailableView(
                    String(localized: text),
                    systemImage: SFSymbol.menucard.rawValue,
                    description: .init(.init(
                        "Select a definition in the sidebar.",
                        comment: "DetailView (No selection description)"
                    ))
                )
            } else {
                Text(text)
            }
        }
    }
}

// swiftlint:disable no_magic_numbers
#Preview {
    DetailView(navigation: .constant(["TestObject"]), document: .init())
        .frame(width: 400, height: 300)
}
// swiftlint:enable no_magic_numbers
