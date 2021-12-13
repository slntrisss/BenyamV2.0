//
//  PlaylistCell.swift
//  BenyamV2.0
//
//  Created by Raim on 06.12.2021.
//

import UIKit

class PlaylistCell: UICollectionViewCell {
    static let identifier = "PlaylistCell"
    @IBOutlet weak var posterImage:UIImageView!
    @IBOutlet weak var title:UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func configure(_ playlist:Playlist){
        posterImage.image = UIImage(named: playlist.posterName)
        title.text = playlist.name
        resizeImageView()
    }
    
    func resizeImageView(){
        posterImage.layer.cornerRadius = posterImage.frame.width / 8
    }

}
