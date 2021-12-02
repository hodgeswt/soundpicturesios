//
//  TripleSpacer.swift
//  sound pictures
//
//  Created by Will Hodges on 12/1/21.
//

import SwiftUI

struct TripleSpacer: View {
    var body: some View {
        VStack {
            Spacer().fixedSize()
            Spacer().fixedSize()
            Spacer().fixedSize()
        }
    }
}

struct TripleSpacer_Preview: PreviewProvider {
    static var previews: some View {
        TripleSpacer()
    }
}
