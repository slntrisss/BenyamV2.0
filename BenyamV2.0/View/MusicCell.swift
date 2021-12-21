//
//  MusicCell.swift
//  BenyamV2.0
//
//  Created by Raim on 06.12.2021.
//

import UIKit

class MusicCell: UITableViewCell {
    static let identifier = "MusicCell"
    @IBOutlet weak var coverImage:UIImageView!
    @IBOutlet weak var songTitle: UILabel!
    @IBOutlet weak var artistName:UILabel!
    
    func configure(_ song:Song){
        coverImage.image = UIImage(named: song.coverName)
        songTitle.text = song.songName
        artistName.text = song.artistName
        resizeImageView()
    }
    
    func resizeImageView(){
        coverImage.layer.cornerRadius = coverImage.frame.width / 8
    }
}
