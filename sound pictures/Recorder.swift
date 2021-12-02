//
//  Recorder.swift
//  sound pictures
//
//  Created by Will Hodges on 12/1/21.
//
import Foundation
import AVFAudio

class Recorder: ObservableObject {
    
    var recorder: AVAudioRecorder! = nil
    
    func record(url: URL) -> Bool {
        let session = AVAudioSession.sharedInstance()
        
        do {
            try session.setCategory(.playAndRecord, mode: .default)
            try session.setActive(true)
        } catch {
            return false
        }
        
        let settings = [
                    AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                    AVSampleRateKey: 12000,
                    AVNumberOfChannelsKey: 1,
                    AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
                ]
        
        do {
            self.recorder = try AVAudioRecorder(url: url, settings: settings)
            self.recorder.record()

            return true
        } catch {
            return false
        }
    }
    
    func stop() {
        self.recorder.stop()
    }
}
