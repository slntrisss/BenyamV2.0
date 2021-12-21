//
//  MiniPlayerViewController.swift
//  BenyamV2.0
//
//  Created by Raim on 08.12.2021.
//

import UIKit
import AVFoundation
class MiniPlayerViewController:UIViewController {
    @IBOutlet weak var songTitle:UILabel!
    @IBOutlet weak var artistName:UILabel!
    @IBOutlet weak var holderView:UIView!
    @IBOutlet weak var btnPlayOrPause: UIButton!
    @IBOutlet weak var btnClose: UIButton!
    weak var miniPlayerView:UIView?
    var player:AVAudioPlayer?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func removeAndStopAudio(_ sender: Any) {
        if let player = player{
            player.stop()
            PlayerViewController.shared.player = nil
        }
        miniPlayerView?.isHidden = true
    }
    
    @IBAction func playOrPauseAudio(_ sender: Any) {
        if let player = player{
            if player.isPlaying{
                player.pause()
                btnPlayOrPause.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
            }
            else{
                player.play()
                btnPlayOrPause.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
            }
        }
    }
    func configure(_ song:Song, _ miniPlayerView: UIView, _ player:AVAudioPlayer){
        self.player = player
        songTitle.text = song.songName
        artistName.text = song.artistName
        btnPlayOrPause.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
        self.miniPlayerView = miniPlayerView
        if player.isPlaying{
            btnPlayOrPause.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
        }
        else{
            btnPlayOrPause.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
        }
    }
}
