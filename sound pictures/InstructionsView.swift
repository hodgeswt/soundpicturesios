//
//  InstructionsView.swift
//  sound pictures
//
//  Created by Will Hodges on 12/2/21.
//

import SwiftUI
import TextView

struct InstructionsView: View {
    
    @State var instructions: String = """
    sound pictures converts sound to three image representations of that sound.
                                    
    example images are available on the 'see examples' page.
                                    
    to record a sound, go to the 'record a sound' page and click the red record button. to stop, click the button again. once recorded, a playback option becomes available. if you want to re-record, simply re-press the record button. when you're done, click the 'convert' button and the images appear below.
    
    to save an image to your camera roll, long press to receive a pop-up.
    
    to view an image larger, tap on it to show an expanded view.
                                    
    your sound files are not stored on your device nor on the sound pictures server, available at soundpictures.herokuapp.com
                                    
    your audio file is sent over HTTP, not HTTPS, and thus could be intercepted between your device and the server.
    """
    
    @State var isEditing = false
        
    var body: some View {
        VStack{
            TextView(
                text: $instructions,
                isEditing: $isEditing,
                isEditable: false,
                isSelectable: false
            )
        }
        .padding()
        .navigationTitle("instructions")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct InstructionsView_Preview: PreviewProvider {
    static var previews: some View {
        InstructionsView()
    }
}
