//
//  AudioManager.swift
//  Wildz
//
//  Created by Tanya Koldunova on 30.10.2022.
//

import Foundation
import AVFoundation

var player: AVAudioPlayer?
var pressedPlayer: AVAudioPlayer?
var congratulationPlayer: AVAudioPlayer?
var fallPlayer: AVAudioPlayer?
var collectPlayer: AVAudioPlayer?
var zombiePlayer: AVAudioPlayer?
var thunderPlayer: AVAudioPlayer?

func playBackgroundMusic() {
    if !UserDefaultsValues.musicOff {
    guard let url = Bundle.main.url(forResource: "background",
                                    withExtension: "mp3") else { return }
    do {
        try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
        try AVAudioSession.sharedInstance().setActive(true)
        player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
        guard let player = player else { return }
        player.volume = 0.1
        player.numberOfLoops = -1
        player.play()
    } catch let error {
        print(error.localizedDescription)
    }
    }
}

func pressedButtonSound() {
    if !UserDefaultsValues.soundOff {
    guard let url = Bundle.main.url(forResource: "pressSound",
                                    withExtension: "wav") else { return }
    do {
        try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
        try AVAudioSession.sharedInstance().setActive(true)
        pressedPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)
        guard let pressedPlayer = pressedPlayer else { return }
        pressedPlayer.volume = 1.0
        pressedPlayer.numberOfLoops = 0
        pressedPlayer.play()
    } catch let error {
        print(error.localizedDescription)
    }
    }
}

func congratulationSoundPlay() {
    if !UserDefaultsValues.soundOff {
    guard let url = Bundle.main.url(forResource: "congratulation",
                                    withExtension: "mp3") else { return }
    do {
        try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
        try AVAudioSession.sharedInstance().setActive(true)
        congratulationPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
        guard let congratulationPlayer = congratulationPlayer else { return }
        congratulationPlayer.volume = 1.0
        congratulationPlayer.numberOfLoops = 0
        stopPlaying()
        congratulationPlayer.play()
        DispatchQueue.main.asyncAfter(deadline: .now()+1.0, execute: {
            playBackgroundMusic()
        })
    } catch let error {
        print(error.localizedDescription)
    }
    }
}

func fallSoundPlay() {
    if !UserDefaultsValues.soundOff {
    guard let url = Bundle.main.url(forResource: "fallSound",
                                    withExtension: "wav") else { return }
    do {
        try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
        try AVAudioSession.sharedInstance().setActive(true)
        fallPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)
        guard let fallPlayer = fallPlayer else { return }
        fallPlayer.volume = 0.5
        fallPlayer.numberOfLoops = 0
        fallPlayer.play()
    } catch let error {
        print(error.localizedDescription)
    }
    }
}

func collectSoundPlay() {
    if !UserDefaultsValues.soundOff {
    guard let url = Bundle.main.url(forResource: "starCollect",
                                    withExtension: "mp3") else { return }
    do {
        try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
        try AVAudioSession.sharedInstance().setActive(true)
        collectPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
        guard let collectPlayer = collectPlayer else { return }
        collectPlayer.volume = 1.0
        collectPlayer.numberOfLoops = 0
        collectPlayer.play()
    } catch let error {
        print(error.localizedDescription)
    }
    }
}

func zombieSoundPlay() {
    if !UserDefaultsValues.soundOff {
    guard let url = Bundle.main.url(forResource: "zombieSounds",
                                    withExtension: "mp3") else { return }
    do {
        try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
        try AVAudioSession.sharedInstance().setActive(true)
        zombiePlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
        guard let zombiePlayer = zombiePlayer else { return }
        zombiePlayer.volume = 1.0
        zombiePlayer.numberOfLoops = 0
        zombiePlayer.play()
    } catch let error {
        print(error.localizedDescription)
    }
    }
}


func thunderSoundPlay() {
    if !UserDefaultsValues.soundOff {
    guard let url = Bundle.main.url(forResource: "thunder",
                                    withExtension: "mp3") else { return }
    do {
        try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
        try AVAudioSession.sharedInstance().setActive(true)
        thunderPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
        guard let thunderPlayer = thunderPlayer else { return }
        thunderPlayer.volume = 1.0
        thunderPlayer.numberOfLoops = 0
        thunderPlayer.play()
    } catch let error {
        print(error.localizedDescription)
    }
    }
}



func stopPlaying() {
    player?.stop()
}
