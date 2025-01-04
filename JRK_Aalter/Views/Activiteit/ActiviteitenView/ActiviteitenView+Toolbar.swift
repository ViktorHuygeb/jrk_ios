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
        if isLeiding {
            ToolbarItem() {
                Button(action: {viewModel.openAddSheet()}){
                    Image(systemName: "plus")
                }
            }
        }
        ToolbarItemGroup(placement: .bottomBar) {
            Spacer()
            ToolbarStatus(isLoading: viewModel.isLoading, lastUpdated: lastUpdated, itemType: "activiteiten", itemCount: viewModel.activiteitenCount)
            Spacer()
        }
    }
}
