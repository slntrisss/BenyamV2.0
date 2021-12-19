//
//  PlaylistViewController.swift
//  BenyamV2.0
//
//  Created by Raim on 08.12.2021.
//

import UIKit
class PlaylistViewController:UIViewController, UITableViewDataSource, UITableViewDelegate{
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var miniPlayerView: UIView!
    @IBOutlet weak var navBarItem: UINavigationItem!
    weak var miniPlayer:MiniPlayerViewController?
    var songs:[Song] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        if(miniPlayerView.isHidden == false){
            miniPlayerView.isHidden = true
        }
        if let _ = PlayerViewController.shared.player{
            miniPlayerView.isHidden = false
            let position = PlayerViewController.shared.position
            let song = PlayerViewController.shared.songs[position]
            configureMiniPlayer(song)
        }
    }
    
    func configure(_ playlist:Playlist){
        self.songs = playlist.songs
        navBarItem.title = playlist.name
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if(miniPlayerView.isHidden == true){
            miniPlayerView.isHidden = false
        }
        let position = indexPath.row
        let song = songs[position]
        //miniPlayer?.configure(song, miniPlayerView)
        PlayerViewController.shared.songs = songs
        PlayerViewController.shared.position = indexPath.row
        PlayerViewController.shared.configure()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlaylistViewControllerCell.identifier, for: indexPath) as! PlaylistViewControllerCell
        cell.configure(songs[indexPath.row])
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "nowPlayingBar"){
            if let destination = segue.destination as? MiniPlayerViewController {
                miniPlayer = destination
            }
        }
    }
    func configureMiniPlayer(_ song:Song){
        if let miniplayer = miniPlayer{
            //miniplayer.configure(song, miniPlayerView)
        }
    }
}
