//
//  NestedPlaylistController.swift
//  BenyamV2.0
//
//  Created by Raim on 21.12.2021.
//

import Foundation
import UIKit
class NestedPlaylistController:UIViewController,UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var tableView: UITableView!
    var songs = [Song]()
    var playerVC:PlayerViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        if let playerVC = playerVC{
            self.songs = playerVC.songs
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        playerVC?.player?.stop()
        playerVC?.player = nil
        playerVC?.songs = self.songs
        playerVC?.position = indexPath.row
        playerVC?.configure()
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NestedPlaylistViewControllerCell.identifier, for: indexPath) as! NestedPlaylistViewControllerCell
        cell.configure(playerVC!.songs[indexPath.row], playerVC!)
        return cell
    }
    
}
