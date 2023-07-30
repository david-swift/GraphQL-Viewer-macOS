//
//  ExportView.swift
//  GraphQL Viewer
//
//  Created by david-swift on 29.06.2023.
//

import SwiftUI

/// A view showing options for exporting as a Swift package.
struct ExportView: View {

    /// The view model.
    @EnvironmentObject var viewModel: ViewModel
    /// Whether the file sheet is displayed.
    @State private var export = false
    /// The document.
    var document: GraphQLDocument

    /// The width.
    let width = 100.0

    /// The view's body.
    var body: some View {
        Form {
            TextField(.init("Package Name", comment: "ExportView (Package name)"), text: $viewModel.packageName)
            TextField(.init("Creator Name", comment: "ExportView (Creator name)"), text: $viewModel.creatorName)
            TextField(.init(
                "Creator GitHub Account URL",
                comment: "ExportView (Account URL)"
            ), text: $viewModel.creatorGitHub)
            TextField(.init(
                "GitHub Repository URL",
                comment: "ExportView (Repo URL)"
            ), text: $viewModel.repositoryGitHub)
            Section(.init("Scalars", comment: "ExportView (Scalars section)")) {
                List($viewModel.scalars, id: \.0) { $scalar in
                    HStack {
                        Text(scalar.0)
                        Spacer()
                        Picker(.init(
                            "Swift Type",
                            comment: "ExportView (Swift type picker)"
                        ), selection: scalar.1.binding { scalar.1 = $0 }) {
                            ForEach(SwiftType.allCases, id: \.hashValue) { type in
                                Text(type.rawValue)
                                    .tag(type)
                            }
                        }
                        .frame(width: width)
                        .labelsHidden()
                    }
                }
            }
        }
        .formStyle(.grouped)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button.cancelButton {
                    viewModel.export = false
                }
                .labelStyle(.titleOnly)
            }
            ToolbarItem(placement: .primaryAction) {
                Button.confirmationButton {
                    export = true
                }
                .labelStyle(.titleOnly)
            }
        }
        .fileImporter(isPresented: $export, allowedContentTypes: [.folder]) { result in
            if let url = try? result.get() {
                var name = NSApplication.shared.mainWindow?.title ?? .init()
                let suffix = ".graphql"
                if name.hasSuffix(suffix) { name = .init(name.dropLast(suffix.count)) }
                if let bookmark = try? url.bookmarkData() {
                    var isStale = false
                    if let url = try? URL(resolvingBookmarkData: bookmark, bookmarkDataIsStale: &isStale), !isStale {
                        _ = url.startAccessingSecurityScopedResource()
                        try? document.createSwiftPackage(
                            packageName: viewModel.packageName,
                            creatorName: viewModel.creatorName,
                            creatorGitHub: viewModel.creatorGitHub,
                            repositoryGitHub: viewModel.repositoryGitHub,
                            scalars: viewModel.scalars.reduce(into: [String: String]()) { partialResult, nextElement in
                                partialResult[nextElement.0] = nextElement.1.rawValue
                            },
                            targetDirectory: url
                        )
                        url.stopAccessingSecurityScopedResource()
                    }
                }
            }
        }
    }
}

#Preview {
    ExportView(document: .init())
}
