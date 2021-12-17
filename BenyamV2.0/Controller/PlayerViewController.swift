//
//  PlayerViewController.swift
//  BenyamV2.0
//
//  Created by Raim on 17.12.2021.
//
import UIKit
import AVFoundation
class PlayerViewController:UIViewController{
    var player:AVAudioPlayer?
    var songs:[Song] = []
    var position = 0
    @IBOutlet var playerView: UIView!
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var songName: UILabel!
    @IBOutlet weak var artistName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configure()
    }
    
    func configure(){
        let song = songs[position]
        let urlString = Bundle.main.path(forResource: song.songName, ofType: "m4a")
        let audioSession = AVAudioSession.sharedInstance()
        poster.image = UIImage(named: song.coverName)
        songName.text = song.songName
        artistName.text = song.artistName
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
