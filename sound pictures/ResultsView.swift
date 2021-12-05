//
//  ResultsView.swift
//  sound pictures
//
//  Created by Will Hodges on 12/5/21.
//

import SwiftUI

struct ResultsView: View {
    
    let imageJson: [String: String]!
    
    @State var showSaveAlert = false
    
    var body: some View {
        VStack {
            ResultsImageView(uiImage: UIImage(data: Data(base64Encoded: self.imageJson["orig"]!)!)!)
            Spacer()
            ResultsImageView(uiImage: UIImage(data: Data(base64Encoded: self.imageJson["new"]!)!)!)
            Spacer()
            ResultsImageView(uiImage: UIImage(data: Data(base64Encoded: self.imageJson["avg"]!)!)!)
        }
    }
}
