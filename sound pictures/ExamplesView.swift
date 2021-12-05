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
            VStack {
                ImageView(name: "new")
                Spacer()
                ImageView(name: "orig")
                Spacer()
                ImageView(name: "avg")
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
