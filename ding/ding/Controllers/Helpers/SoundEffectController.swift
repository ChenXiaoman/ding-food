//
//  SoundEffectController.swift
//  ding
//
//  Created by Yunpeng Niu on 12/04/18.
//  Copyright © 2018 CS3217 Ding. All rights reserved.
//

import AVFoundation

/**
 A controller which governs all the sound effects within the application.

 - Author: Group 3 @ CS3217
 - Date: April 2018
 */
class SoundEffectController {
    /// The player for background music.
    private var player: AVAudioPlayer?
    /// The default extension name for sound effects.
    private static let ext = "mp3"

    /// Plays a certain sound effect once.
    /// - Parameter effect: The sound effect played.
    func play(_ effect: SoundEffect) {
        let fileName = effect.rawValue
        guard let url = Bundle.main.url(forResource: fileName, withExtension: SoundEffectController.ext) else {
            return
        }
        player = try? AVAudioPlayer(contentsOf: url)
        player?.prepareToPlay()
        player?.play()
    }
}

/**
 An enum for all possible sound effects.
 */
enum SoundEffect: String {
    case ring = "front_desk_bell"
}
