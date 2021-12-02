//
//  ContentView.swift
//  sound pictures
//
//  Created by Will Hodges on 12/1/21.
//

import SwiftUI
import CoreData

struct ContentView: View {

    var body: some View {
        NavigationView {
            VStack {
                Text("sound pictures")
                    .font(.largeTitle)
                
                TripleSpacer()
                
                NavigationLink(destination: RecordView()) {
                    Text("record a sound")
                        .font(.title)
                }
                
                TripleSpacer()
                
                NavigationLink(destination: ExamplesView()) {
                    Text("see examples")
                        .font(.title)
                }
                
                Spacer()
                
            }
            .navigationBarTitle("")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
