//
//  TrailingIconLabelStyle.swift
//  JRK_IOS
//
//  Created by Viktor Huygebaert on 27/12/2024.
//
//  This is used to create a consistent labelstyle accross the whole app
//  It's the label followed by an icon
import SwiftUI

struct TrailingIconLabelStyle: LabelStyle {
    //  In the configuration, all the info of the LabelStyleConfiguration is stored here, like title and icon
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.title
            configuration.icon
        }
    }
}

extension LabelStyle where Self == TrailingIconLabelStyle {
    static var trailingIcon: Self { Self() }
}

