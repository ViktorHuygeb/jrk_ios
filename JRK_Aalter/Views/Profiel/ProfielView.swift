//
//  ProfielView.swift
//  JRK_Aalter
//
//  Created by Viktor Huygebaert on 30/12/2024.
//

import SwiftUI

struct ProfielView: View {
    var body: some View {
        VStack() {
            Text("Dit wordt de profielpagina")
                .font(.headline)
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color.blue)
        .edgesIgnoringSafeArea(.horizontal)
    }
}

struct ProfielView_Previews: PreviewProvider{
    static var previews: some View {
        ProfielView()
    }
}
