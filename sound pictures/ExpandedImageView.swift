//
//  ExpandedImageView.swift
//  sound pictures
//
//  Created by Will Hodges on 12/5/21.
//

import SwiftUI

struct ExpandedImageView: View {
    
    var image: Image
    var uiImage: UIImage
    
    @State var showSaveAlert = false
    
    var body: some View {
        VStack {
            image
                .resizable()
                .scaledToFit()
                .onLongPressGesture {
                    self.showSaveAlert = true
                }
                .border(Color.gray, width: 1)
                .alert("Save image to camera roll?", isPresented: $showSaveAlert) {
                    Button("Yes") {
                        UIImageWriteToSavedPhotosAlbum(self.uiImage, nil, nil, nil)
                        
                        self.showSaveAlert = false
                    }
                    Button("No", role: .cancel) {
                        self.showSaveAlert = false
                    }
                }
        }
    }
}

struct ExpandedImageView_Preview: PreviewProvider {
    static var previews: some View {
        ExpandedImageView(image: Image("new"), uiImage: UIImage(imageLiteralResourceName: "new.png"))
    }
}
