//
//  LedenView.swift
//  JRK_Aalter
//
//  Created by Viktor Huygebaert on 30/12/2024.
//

import SwiftUI

struct LedenView: View {
    var body: some View {
        VStack() {
            Text("Dit wordt de ledenpagina")
                .font(.headline)
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color.red)
        .edgesIgnoringSafeArea(.horizontal)
    }
}

struct LedenView_Previews: PreviewProvider{
    static var previews: some View {
        LedenView()
    }
}
