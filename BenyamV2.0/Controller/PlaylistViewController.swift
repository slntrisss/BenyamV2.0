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
    weak var delegate:NestedViewControllerHandler?
    var songs:[Song] = []
    var playerVC:PlayerViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        miniPlayerView.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let playerVC = self.playerVC{
            if(self.miniPlayerView.isHidden == true){
                self.miniPlayerView.isHidden = false
            }
            self.miniPlayer?.configure(playerVC.songs[playerVC.position], self.miniPlayerView, playerVC.player!)
        }
    }
    func configure(_ playlist:Playlist, _ playerVC: PlayerViewController){
        self.songs = playlist.songs
        self.playerVC = playerVC
        navBarItem.title = playlist.name
    }
    
    func configure(_ playlist:Playlist){
        self.songs = playlist.songs
        navBarItem.title = playlist.name
        self.miniPlayer = playerVC?.miniPlayer
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
        delegate?.pushToSuperView(withViewController: playerVC!)
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
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let playerVC = playerVC{
            delegate?.pushToSuperView(withViewController: playerVC)
        }
    }
}
