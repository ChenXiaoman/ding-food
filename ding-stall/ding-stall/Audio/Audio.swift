//
//  Audio.swift
//  ding-stall
//
//  Created by Calvin Tantio on 12/4/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import AVFoundation

struct Audio {
    static func setupPlayer(fileName: String, loop: Int) -> AVAudioPlayer? {

        let player: AVAudioPlayer?

        let audioPath = Bundle.main.path(forResource: fileName, ofType: "mp3")

        do {
            guard let path = audioPath else {
                return nil
            }

            try player = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: path) as URL)
            player?.prepareToPlay()
        } catch {
            return nil
        }

        player?.numberOfLoops = loop

        return player
    }
}
