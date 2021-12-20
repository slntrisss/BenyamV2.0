//
//  NestedPlaylistViewControllerCell.swift
//  BenyamV2.0
//
//  Created by Raim on 21.12.2021.
//

import Foundation
import UIKit
class NestedPlaylistViewControllerCell:UITableViewCell{
    static let identifier = "NestedPlaylistViewControllerCell"
    
    @IBOutlet weak var songImage: UIImageView!
    @IBOutlet weak var songName: UILabel!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var playOrPauseButton: UIButton!
    var playerVC:PlayerViewController?
    
    func configure(_ song:Song, _ playerVC:PlayerViewController){
        self.songImage.image = UIImage(named: song.coverName)
        self.songName.text = song.songName
        self.artistName.text = song.artistName
        self.playerVC = playerVC
        playOrPauseButton.isHidden = true
        if let player = playerVC.player{
            if song.songName == playerVC.songs[playerVC.position].songName{
                if(player.isPlaying){
                    playOrPauseButton.isHidden = false
                    playOrPauseButton.setBackgroundImage(UIImage(systemName: "pause.circle"), for: .normal)
                }
            }
        }
    }
    @IBAction func didTapPlayOrPauseButton(_ sender: Any) {
        if(playerVC!.player!.isPlaying){
            playOrPauseButton.setBackgroundImage(UIImage(systemName: "play.circle"), for: .normal)
            playerVC?.player?.pause()
        }
        else{
            playOrPauseButton.setBackgroundImage(UIImage(systemName: "pause.circle"), for: .normal)
            playerVC?.player?.play()
        }
    }
}
