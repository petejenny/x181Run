//
//  Audio.swift
//  x181Run
//
//  Created by Peter Forward on 6/20/19.
//  Copyright © 2019 Peter Forward. All rights reserved.
//

import UIKit
import AVFoundation

var player: AVAudioPlayer?

func playSound() {
    if let asset = NSDataAsset(name: "myExclamation") {
        do {
            player = try AVAudioPlayer(data:asset.data, fileTypeHint: "AU")
            player?.play()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}
