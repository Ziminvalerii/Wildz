//
//  VibrationManager.swift
//  Wildz
//
//  Created by Tanya Koldunova on 30.10.2022.
//

import Foundation
import AudioToolbox

func playVibration() {
    if !UserDefaultsValues.vibrationOff {
    AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
    }
}

func playPopVibration() {
    if !UserDefaultsValues.vibrationOff {
        AudioServicesPlaySystemSound(1520)
    }
}


