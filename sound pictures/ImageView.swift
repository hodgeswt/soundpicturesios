//
//  ImageView.swift
//  sound pictures
//
//  Created by Will Hodges on 12/5/21.
//

import SwiftUI

struct ImageView: View {
    
    var name: String
    
    @State var imageToSave = 0
    @State var showSaveAlert = false
    @State var showDetailView = false
    
    var body: some View {
        NavigationLink(
            destination: ExpandedImageView(
                image: Image(self.name),
                uiImage: UIImage(imageLiteralResourceName: self.name + ".png")),
            isActive: $showDetailView) {
                    EmptyView()
            }
        
        
        Image(self.name)
            .resizable()
            .scaledToFit()
            .border(Color.gray, width: 1)
            .onTapGesture {
                self.showDetailView = true
            }
            .simultaneousGesture(LongPressGesture()
                .onEnded { _ in
                    self.showSaveAlert = true
                })
            .alert("Save image to camera roll?", isPresented: $showSaveAlert) {
                Button("Yes") {
                    UIImageWriteToSavedPhotosAlbum(UIImage(imageLiteralResourceName: self.name + ".png"), nil, nil, nil)
                    
                    self.showSaveAlert = false
                }
                Button("No", role: .cancel) {
                    self.showSaveAlert = false
                }
            }
    }
}

struct ImageView_Preview: PreviewProvider {
    static var previews: some View {
        ImageView(name: "orig")
    }
}

