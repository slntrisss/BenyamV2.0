//
//  ViewController.swift
//  BenyamV2.0
//
//  Created by Raim on 29.11.2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NestedCellHandler {
    @IBOutlet weak var table:UITableView!
    @IBOutlet weak var mainView:UIView!
    var miniPlayer:MiniPlayerViewController?
    var playlistVC: PlaylistViewController?
    var playlist:Playlist?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        table.delegate = self;
        table.dataSource = self;
        mainView.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if(mainView.isHidden == true){
            mainView.isHidden = false
        }
        let song = MusicDAO.shared.songs[indexPath.row]
        miniPlayer?.configure(song)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        MusicDAO.shared.songs.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "nowPlayingBar"){
            if let destination = segue.destination as? MiniPlayerViewController {
                miniPlayer = destination
            }
        }
        if(segue.identifier == "playlistViewController"){
            guard let playlistVC = segue.destination as? PlaylistViewController else{
                return
            }
            if let playlist = playlist {
                playlistVC.songs = playlist.songs
                print(playlist.songs)
            }
        }
    }
    
    func pushToSuperView(withData: Playlist) {
        playlist = withData
        performSegue(withIdentifier: "playlistViewController", sender: self)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == 0){
            let playlistsCell = tableView.dequeueReusableCell(withIdentifier: PlaylistTableViewCell.identifier, for: indexPath) as! PlaylistTableViewCell
            let playlists = MusicDAO.shared.playlists
            playlistsCell.configure(playlists)
            playlistsCell.delegate = self
            return playlistsCell
        }
        
        let musicCell = tableView.dequeueReusableCell(withIdentifier: MusicCell.identifier, for: indexPath) as! MusicCell
        musicCell.configure(MusicDAO.shared.songs[indexPath.row])
        return musicCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.row == 0){
            return 240
        }
        return 60
    }
}
