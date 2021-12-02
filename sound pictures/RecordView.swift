//
//  RecordView.swift
//  sound pictures
//
//  Created by Will Hodges on 12/1/21.
//

import SwiftUI
import AVFoundation

struct RecordView: View {
    
    var audioRecorder: AVAudioRecorder!
    let audioSession: AVAudioSession = AVAudioSession.sharedInstance()
    
    @State var buttonState = false
    
    var body: some View {
        VStack {
            Button(buttonState ? "stop recording" : "press to record", action: {
                print("pre-permission check")
                var permission = false
                switch audioSession.recordPermission {
                    case AVAudioSession.RecordPermission.granted:
                            permission = true
                            break
                    default:
                            permission = false
                    audioSession.requestRecordPermission({
                        (p) in
                        permission = p
                    })
                        break
                
                }
                print("post-check")
                
//                if !self.buttonState && permission {
//                    print("testing")
//                }
//                
//                self.buttonState = !buttonState
            })
        }
        .navigationTitle("record")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct RecordView_Preview: PreviewProvider {
    static var previews: some View {
        RecordView()
    }
}
