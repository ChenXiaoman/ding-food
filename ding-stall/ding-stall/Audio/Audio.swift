//
//  Audio.swift
//  ding-stall
//
//  Created by Calvin Tantio on 12/4/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import UIKit
import AVFoundation

struct Audio {
    static func setupPlayer(fileName: String, loop: Int) -> AVAudioPlayer? {

        let player: AVAudioPlayer?

        let audioPath = Bundle.main.path(forResource: fileName, ofType: "mp3")

        do {
            try player = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
            player?.prepareToPlay()
        } catch {
            return nil
        }

        guard let audioPlayer = player else {
            return nil
        }

        audioPlayer.numberOfLoops = loop

        return audioPlayer
    }
}
