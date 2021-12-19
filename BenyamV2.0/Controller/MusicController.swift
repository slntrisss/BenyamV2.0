//
//  MusicController.swift
//  BenyamV2.0
//
//  Created by Raim on 17.12.2021.
//

import Foundation
import AVFoundation
import Firebase
class MusicController{
    static let shared = MusicController()
    var player:AVAudioPlayer?
    var songs:[Song] = []
    var position = 0
    var playerVC:PlayerViewController?
    func configure(_ songs:[Song], _ position:Int){
        let song = songs[position]
        let pathString = "music/" + song.fileName + ".m4a"
        print(pathString)
        let storageReference = Storage.storage().reference().child(pathString)
        let fileUrls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        guard let fileUrl = fileUrls.first?.appendingPathComponent(pathString) else {
            return
        }

        let downloadTask = storageReference.write(toFile: fileUrl)

        downloadTask.observe(.success) { _ in
            do {
                self.player = try AVAudioPlayer(contentsOf: fileUrl)
                self.player?.prepareToPlay()
                self.player?.play()
                self.player?.setVolume(AVAudioSession.sharedInstance().outputVolume, fadeDuration: .infinity)
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
}
