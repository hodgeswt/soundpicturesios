//
//  Player.swift
//  sound pictures
//
//  Created by Will Hodges on 12/1/21.
//

import Foundation
import AVFAudio

class Player: ObservableObject {
    var player: AVAudioPlayer!
    
    func play(url: URL) {
        let session = AVAudioSession.sharedInstance()
        
        do {
            try session.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
            self.player = try AVAudioPlayer(contentsOf: url)
            self.player.play()
        } catch { }
    }
    
    func stop() {
        self.player.stop()
    }
}
