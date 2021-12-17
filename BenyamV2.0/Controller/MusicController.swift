//
//  MusicController.swift
//  BenyamV2.0
//
//  Created by Raim on 17.12.2021.
//

import Foundation
import AVFoundation
class MusicController{
    static let shared = MusicController()
    var player:AVAudioPlayer?
    var songs:[Song] = []
    var position = 0
    func configure(_ songs:[Song], _ position:Int){
        let song = songs[position]
        let urlString = Bundle.main.path(forResource: song.songName, ofType: "m4a")
        let audioSession = AVAudioSession.sharedInstance()
        do{
            try audioSession.setCategory(.playback)
            try audioSession.setMode(.default)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
            guard let urlString = urlString else{
                return
            }
            
            player = try AVAudioPlayer(contentsOf: URL(string: urlString)!)
            guard let player = player else{
                return
            }
            player.play()
        }catch{
            print("error")
        }
    }
}
