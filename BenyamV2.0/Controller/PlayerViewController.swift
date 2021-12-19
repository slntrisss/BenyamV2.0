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
    @IBOutlet weak var btnPlayOrPause: UIButton!
    @IBOutlet weak var timeIntervalSlider: UISlider!
    @IBOutlet weak var playedTime: UILabel!
    @IBOutlet weak var leftTime: UILabel!
    @IBOutlet weak var volumeSlider: UISlider!
    var miniPlayer:MiniPlayerViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        _ = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateSliderInterval), userInfo: nil, repeats: true)
        guard let player = player else {
            return
        }
        timeIntervalSlider.maximumValue = Float(player.duration)
        self.volumeSlider.value = Float(player.volume)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configure()
    }
    func configure(){
        let song = songs[position]
        poster.image = UIImage(named: song.coverName)
        songName.text = song.songName
        artistName.text = song.artistName
    }
    @IBAction func pauseOrPlayButton(_ sender: Any) {
        if let player = player{
            if player.isPlaying{
                btnPlayOrPause.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
                player.pause()
                miniPlayer?.btnPlayOrPause.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
            }
            else {
                btnPlayOrPause.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
                player.play()
                miniPlayer?.btnPlayOrPause.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
            }
        }
    }
    @IBAction func setTimeInterval(_ sender: Any) {
        if let player = player{
            player.stop();
            player.currentTime = TimeInterval(timeIntervalSlider.value)
            player.prepareToPlay()
            player.play()
        }
    }
    @objc func updateSliderInterval(){
        if let player = player{
            timeIntervalSlider.setValue(Float(player.currentTime), animated: true)
            
            let time1 = player.duration
            let time2 = player.currentTime
            
            // this is to compute and show remaining time
            let duration = Int(time1 - (time2))
            let minutes2 = duration/60
            let seconds2 = duration - minutes2 * 60
            leftTime.text = String(format: "%02d:%02d", minutes2,seconds2) as String

            //This is to show and compute current time
            let currentTime1 = Int((time2))
            let minutes = currentTime1/60
            let seconds = currentTime1 - minutes * 60
            playedTime.text = String(format: "%02d:%02d", minutes,seconds) as String
        }
    }
    @IBAction func setVolume(_ sender: Any) {
        if let player = player{
            let value = volumeSlider.value
            player.setVolume(value, fadeDuration:.infinity)
        }
    }
    @IBAction func didTapBackButton(_ sender: Any) {
        if position > 0{
            player?.stop()
            position -= 1
            poster.image = nil
            songName.text = ""
            artistName.text = ""
            if let _ = MusicController.shared.player{
                player = nil
                MusicController.shared.player = nil
                MusicController.shared.configure(songs, position)
            }
            configure()
        }
    }
    @IBAction func didTapNextButton(_ sender: Any) {
        if position < songs.count - 1{
            player?.stop()
            position += 1
            poster.image = nil
            songName.text = ""
            artistName.text = ""
            
            if let _ = MusicController.shared.player{
                player = nil
                MusicController.shared.player = nil
                MusicController.shared.configure(songs, position)
            }
            configure()
        }
    }
    
}
