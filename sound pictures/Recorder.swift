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
    var session = AVAudioSession.sharedInstance()
    
    let settings = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 12000,
                AVNumberOfChannelsKey: 1,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]
    
    init() {
        do {
            try self.session.setCategory(.playAndRecord, mode: .default)
            try self.session.setActive(true)
            
            self.session.requestRecordPermission() { allowed in }
        } catch {
            
        }
    }
    
    func record(url: URL) -> Bool {
        
        do {
            self.recorder = try AVAudioRecorder(url: url, settings: self.settings)
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
