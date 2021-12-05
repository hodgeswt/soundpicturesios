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
    
    @State var receivedImages = false
    @State var imageJson: [String: String]! = nil
    
    @State var showDetailView = false
    
    var url: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("sound.m4a")
    
    @ObservedObject var recorder = Recorder()
    @ObservedObject var player = Player()
    
    private func bytes(url: URL) -> [UInt8]? {
        do {
            // Get the raw data from the file.
            let rawData: Data = try Data(contentsOf: url)
            // Return the raw data as an array of bytes.
            return [UInt8](rawData)
        } catch {
            // Couldn't read the file.
            return nil
        }
    }
    
    @ViewBuilder
    var body: some View {
        VStack {
            NavigationLink(
                destination: ResultsView(imageJson: self.imageJson),
                isActive: $showDetailView) {
                        EmptyView()
                }
            
            Button(action: {
                
                if !self.buttonState {
                    // Start recording
                    self.recorded = false
                    
                    self.buttonState = self.recorder.record(url: self.url)
                    
                    if self.buttonState == false {
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
            
            TripleSpacer()
            
            Button(action: {
                let fileManager = FileManager.default
                let dir = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
                let directoryContents = try! fileManager.contentsOfDirectory(at: dir, includingPropertiesForKeys: nil)
                
                for file in directoryContents {
                    if file.path.hasSuffix("sound.m4a") {
                        // If our file does exist
                        let serverUrl = URL(string: "http://soundpictures.herokuapp.com/sound_picture")
                        
                        let urlSession = URLSession.shared
                        let boundary = UUID().uuidString
                        var data = Data()
                        
                        var urlRequest = URLRequest(url: serverUrl!)
                        urlRequest.httpMethod = "POST"
                        
                        urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
                        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
                        data.append("Content-Disposition: form-data; name=\"data\"; filename=\"data.m4a\"\r\n".data(using: .utf8)!)
                        data.append("Content-Type: \"content-type header\"\r\n\r\n".data(using: .utf8)!)
                        
                        if let bytes: [UInt8] = bytes(url: file) {
                            for byte in bytes {
                                data.append(byte)
                            }
                            
                            data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
                            urlSession.uploadTask(with: urlRequest, from: data, completionHandler: { responseData, response, error in
                                    if error == nil {
                                        let jsonData = try? JSONSerialization.jsonObject(with: responseData!, options: .allowFragments)
                                                if let json = jsonData as? [String: String] {
                                                    self.imageJson = json
                                                    self.showDetailView = true
                                                }
                                    }
                                }
                            ).resume()
                        }
                    }
                }
            }) {
                if recorded {
                    Text("convert")
                }
            }
            
//            if self.receivedImages {
//                self.showDetailView = true
////                Image(uiImage: UIImage(data: Data(base64Encoded: self.imageJson["orig"]!)!)!)
////                    .resizable()
////                    .scaledToFit()
////                Image(uiImage: UIImage(data: Data(base64Encoded: self.imageJson["new"]!)!)!)
////                    .resizable()
////                    .scaledToFit()
////                Image(uiImage: UIImage(data: Data(base64Encoded: self.imageJson["avg"]!)!)!)
////                    .resizable()
////                    .scaledToFit()
//            }
            
            Spacer()
        }
        .alert("Failed to Record", isPresented: $showRecordingFailAlert) {
            Button("OK", role: .cancel) {
                
            }
        }
        .padding()
        .navigationTitle("record")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    
}

struct RecordView_Preview: PreviewProvider {
    static var previews: some View {
        RecordView()
    }
}
