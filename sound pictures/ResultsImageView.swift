//
//  ResultsImageView.swift
//  sound pictures
//
//  Created by Will Hodges on 12/5/21.
//

import SwiftUI

struct ResultsImageView: View {
    
    var uiImage: UIImage
    
    @State var showSaveAlert = false
    @State var showDetailView = false
    
    var body: some View {
        NavigationLink(
            destination: ExpandedImageView(
                image: Image(uiImage: self.uiImage),
                uiImage: self.uiImage),
            isActive: $showDetailView) {
                    EmptyView()
            }
        
        Image(uiImage: self.uiImage)
            .resizable()
            .scaledToFit()
            .onTapGesture {
                self.showDetailView = true
            }
            .onLongPressGesture {
                self.showSaveAlert = true
            }
            .alert("Save image to camera roll?", isPresented: $showSaveAlert) {
                Button("Yes") {
                    UIImageWriteToSavedPhotosAlbum(self.uiImage, nil, nil, nil)
                    
                    self.showSaveAlert = false
                }
                Button("No", role: .cancel) {
                    self.showSaveAlert = false
                }
            }
            .border(Color.gray, width: 1)
    }
}
