//
//  PlaylistTableViewCell.swift
//  BenyamV2.0
//
//  Created by Raim on 06.12.2021.
//

import UIKit

class PlaylistTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource{
    var playlists:[Playlist] = []
    weak var delegate:NestedCellHandler?
    static let identifier = "PlaylistTableViewCell"
    @IBOutlet weak var collectionView:UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(_ playlists:[Playlist]){
        self.playlists = playlists
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return playlists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlaylistCell.identifier, for: indexPath) as! PlaylistCell
        cell.configure(playlists[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        delegate?.pushToSuperView(withData: playlists[indexPath.row])
    }
}
