//
//  View.swift
//  GraphQL Viewer
//
//  Created by david-swift on 18.06.2023.
//

import SwiftUI

extension View {

    /// Apply to a text for a title in the docs.
    /// - Returns: The title.
    func sectionTitle() -> some View {
        let fontSize = 30.0
        let spacerHeight = 20.0
        return VStack {
            font(.system(size: fontSize))
                .fontWeight(.semibold)
            Spacer()
                .frame(height: spacerHeight)
        }
    }

    /// A group view.
    /// - Parameter enabled: Whether it is grouped.
    /// - Returns: The view.
    @ViewBuilder
    func graphQLViewerGroup(enabled: Bool = true) -> some View {
        let backgroundOpacity = 0.1
        if enabled {
            HStack {
                self
                Spacer()
            }
            .padding()
            .background(.gray.opacity(backgroundOpacity), in: RoundedRectangle(cornerRadius: .colibriCornerRadius))
        } else {
            self
        }
    }

}
