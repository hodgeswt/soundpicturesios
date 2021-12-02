//
//  RecordView.swift
//  sound pictures
//
//  Created by Will Hodges on 12/1/21.
//

import SwiftUI
import AVFoundation

struct RecordView: View {
    
    @State var buttonState = false
    @State var showRecordingFailAlert = false
    @State var recording = false
    @State var recorded = false
    
    var url: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("sound.m4a")
    
    @ObservedObject var recorder = Recorder()
    @ObservedObject var player = Player()
    
    
    var body: some View {
        VStack {
            Button(action: {
                
                if !self.buttonState {
                    // Start recording
                    self.recorded = false
                    let session: AVAudioSession! = AVAudioSession.sharedInstance()
                    do {
                        try session.setCategory(.playAndRecord, mode: .default)
                        try session.setActive(true)
                    
                        self.buttonState = self.recorder.record(url: self.url)
                    } catch {
                        self.showRecordingFailAlert = true
                    }
                } else {
                    // Stop recording
                    self.recorder.stop()
                    self.buttonState = false
                    self.recorded = true
                }
                
            }) {
                if !self.buttonState {
                    Image("start")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height:200)
                } else {
                    Image("stop")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height:200)
                }
            }
            
            Button(action: {
                let fileManager = FileManager.default
                let dir = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
                let directoryContents = try! fileManager.contentsOfDirectory(at: dir, includingPropertiesForKeys: nil)
                
                for file in directoryContents {
                    if file.path.hasSuffix("sound.m4a") {
                        // If our file does exist
                        self.player.play(url: self.url)
                    }
                }
            }) {
                if recorded {
                    Text("playback")
                }
            }
            
            Spacer()
        }
        .alert("Failed to Record", isPresented: $showRecordingFailAlert) {
            Button("OK", role: .cancel) {
                
            }
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
