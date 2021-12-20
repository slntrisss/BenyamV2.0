//
//  LyricsViewController.swift
//  BenyamV2.0
//
//  Created by Raim on 20.12.2021.
//

import Foundation
import UIKit
class LyricsViewController:UIViewController{
    @IBOutlet weak var lyrics: UITextView!
    var playerVC:PlayerViewController?
    var lyricsMiniPlayer:LyricsMiniPlayerViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    func configure(){
        guard let playerVC = playerVC else{return}
        let songs = playerVC.songs
        let position = playerVC.position
        let song = songs[position]
        lyrics.text = correctLyrics(song.lyrics)
        lyricsMiniPlayer?.configure(song)
        lyricsMiniPlayer?.playerVC = playerVC
        lyricsMiniPlayer?.lyricsViewController = self
    }
    func configure(_ song:Song){
        lyrics.text = correctLyrics(song.lyrics)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "lyricsMiniPlayer"){
            if let destination = segue.destination as? LyricsMiniPlayerViewController{
                lyricsMiniPlayer = destination
            }
        }
    }
    func correctLyrics(_ text:String) -> String{
        var lyrics = ""
        for i in 0..<text.count {
            let index = text.index(text.startIndex, offsetBy: i)
            if(text[index] == "|"){
                lyrics += "\n"
            }
            else{
                lyrics += "\(text[index])"
            }
        }
        return lyrics
    }
}
