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
    var playerVC:PlayerViewController?
    weak var delegate:NestedViewControllerHandler?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        if(miniPlayerView.isHidden == false){
            miniPlayerView.isHidden = true
        }
        if let playerVC = playerVC{
            if let player = playerVC.player{
                if player.isPlaying{
                    miniPlayerView.isHidden = false
                }
            }
            miniPlayer?.configure(songs[playerVC.position], miniPlayerView, playerVC.player!)
        }
    }
    
    func configure(_ playlist:Playlist, _ playerVC: PlayerViewController, _ miniPlayer:MiniPlayerViewController){
        self.songs = playlist.songs
        self.playerVC = playerVC
        self.miniPlayer = miniPlayer
        navBarItem.title = playlist.name
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
        guard let playerInstanceVC = storyboard?.instantiateViewController(identifier: "player") as? PlayerViewController else{return}
        if let playerVC = playerVC{
            playerVC.player?.stop()
            playerVC.player = nil
        }
        playerVC = playerInstanceVC
        playerVC?.songs = self.songs
        playerVC?.position = indexPath.row
        playerVC?.miniPlayerView = miniPlayerView
        playerVC?.miniPlayer = miniPlayer
        ModelObject.sharedIntance.VC = playerVC
        ModelObject.sharedIntance.miniPlayer = miniPlayer
        present(playerVC ?? playerInstanceVC, animated: true, completion: nil)
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
}
