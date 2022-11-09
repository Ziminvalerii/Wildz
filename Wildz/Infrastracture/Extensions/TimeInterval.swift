//
//  TimeInterval.swift
//  Wildz
//
//  Created by Tanya Koldunova on 07.11.2022.
//

import Foundation


extension TimeInterval {
    func timeString() -> String {
       let minutes = Int(self) / 60 % 60
       let seconds = Int(self) % 60
       return String(format: "%02i%:%02i", minutes, seconds)
   }
}
