//
//  LyricsMiniPlayerViewController.swift
//  BenyamV2.0
//
//  Created by Raim on 20.12.2021.
//

import Foundation
import UIKit
import AVFoundation
class LyricsMiniPlayerViewController:UIViewController{
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var songName: UILabel!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var playOrPauseButton: UIButton!
    var playerVC:PlayerViewController?
    var lyricsViewController:LyricsViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configure()
    }
    func configure(){
        if let playerVC = playerVC {
            let song = playerVC.songs[playerVC.position]
            imageView.image = UIImage(named: song.coverName)
            songName.text = song.songName
            artistName.text = song.artistName
            ensureStreaming(playerVC)
        }
    }
    func configure(_ song:Song){
        if let playerVC = playerVC{
            imageView.image = UIImage(named: song.coverName)
            songName.text = song.songName
            artistName.text = song.artistName
            ensureStreaming(playerVC)
        }
    }
    @IBAction func playOrPauseButton(_ sender: Any) {
        guard let player = playerVC?.player else{return}
        if(player.isPlaying){
            playOrPauseButton.setBackgroundImage(UIImage(systemName: "play.circle"), for: .normal)
            player.pause()
        }
        else{
            playOrPauseButton.setBackgroundImage(UIImage(systemName: "pause.circle"), for: .normal)
            player.play()
        }
    }
    @IBAction func didTapNextButton(_ sender: Any) {
        if let position = playerVC?.position{
            if position < playerVC!.songs.count - 1{
                guard let player = playerVC?.player else {
                    return
                }
                player.stop()
                imageView.image = nil
                songName.text = ""
                artistName.text = ""
                let newIndex = position + 1
                playerVC?.position = newIndex
                playerVC?.configure()
                lyricsViewController?.configure(playerVC!.songs[newIndex])
                configure(playerVC!.songs[newIndex])
            }
        }
    }
    func ensureStreaming(_ playerVC:PlayerViewController){
        if let player = playerVC.player{
            if(player.isPlaying){
                playOrPauseButton.setBackgroundImage(UIImage(systemName: "pause.circle"), for: .normal)
            }
            else{
                playOrPauseButton.setBackgroundImage(UIImage(systemName: "play.circle"), for: .normal)
            }
        }
    }
}
