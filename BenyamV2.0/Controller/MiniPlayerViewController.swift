//
//  MiniPlayerViewController.swift
//  BenyamV2.0
//
//  Created by Raim on 08.12.2021.
//

import UIKit
class MiniPlayerViewController:UIViewController {
    @IBOutlet weak var songTitle:UILabel!
    @IBOutlet weak var artistName:UILabel!
    @IBOutlet weak var holderView:UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func removeAndStopAudio(_ sender: Any) {
        self.holderView.isHidden = true
    }
    @IBAction func splayAndPauseAudio(_ sender: Any) {
    }
    
    func configure(_ song:Song){
        songTitle.text = song.songName
        artistName.text = song.artistName
    }
}
