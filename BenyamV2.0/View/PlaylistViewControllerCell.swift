//
//  PlaylistViewControllerCell.swift
//  BenyamV2.0
//
//  Created by Raim on 08.12.2021.
//

import UIKit

class PlaylistViewControllerCell:UITableViewCell{
    
    static let identifier = "PlaylistViewControllerCell"
    
    @IBOutlet weak var posterImage:UIImageView!
    @IBOutlet weak var songTitle:UILabel!
    @IBOutlet weak var artistName:UILabel!
    
    func configure(_ song:Song){
        posterImage.image = UIImage(named: song.coverName)
        songTitle.text = song.songName
        artistName.text = song.artistName
    }
}
