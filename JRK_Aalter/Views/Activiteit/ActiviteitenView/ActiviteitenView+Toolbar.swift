//
//  ActiviteitenView+Toolbar.swift
//  JRK_Aalter
//
//  Created by Viktor Huygebaert on 02/01/2025.
//

import SwiftUI

extension ActiviteitenView {
    
    @ToolbarContentBuilder
    func toolbarContent() -> some ToolbarContent {
        ToolbarItem() {
            Button(action: {viewModel.openAddSheet()}) {
                Image(systemName: "plus")
            }
            .accessibilityLabel("Voeg een activiteit toe")
        }
        ToolbarItemGroup(placement: .bottomBar) {
            Spacer()
            ToolbarStatus(isLoading: viewModel.isLoading, lastUpdated: lastUpdated, itemType: "activiteiten", itemCount: viewModel.activiteitenCount)
            Spacer()
            
        }
    }
}
