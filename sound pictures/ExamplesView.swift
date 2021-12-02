//
//  ContentView.swift
//  sound pictures
//
//  Created by Will Hodges on 12/1/21.
//

import SwiftUI
import CoreData

struct ExamplesView: View {

    var body: some View {
            ScrollView {
                Image("new")
                    .resizable()
                    .scaledToFit()
                Image("orig")
                    .resizable()
                    .scaledToFit()
                Image("avg")
                    .resizable()
                    .scaledToFit()
            }
            .padding()
            .navigationTitle("examples")
            .navigationBarTitleDisplayMode(.inline)
    }

    
}

struct ExamplesView_Preview: PreviewProvider {
    static var previews: some View {
        ExamplesView()
    }
}
