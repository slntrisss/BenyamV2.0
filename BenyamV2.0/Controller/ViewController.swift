//
//  ViewController.swift
//  BenyamV2.0
//
//  Created by Raim on 29.11.2021.
//

import UIKit
import Firebase
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NestedCellHandler,
                      NestedViewControllerHandler{
    @IBOutlet weak var table:UITableView!
    @IBOutlet weak var mainView:UIView!
    var miniPlayer:MiniPlayerViewController?
    var playlistVC: PlaylistViewController?
    var playlists = [Playlist]()
    var playlist:Playlist?
    var songs = [Song]()
    var playerVC:PlayerViewController?
    var docRef:CollectionReference!
    var position = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        table.delegate = self;
        table.dataSource = self;
        mainView.isHidden = true
        docRef = Firestore.firestore().collection("music")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        docRef.getDocuments { snapshot, error in
            guard let snapshot = snapshot else{return}
            for document in snapshot.documents {
                if(document.documentID == "songs"){
                    let count:Int = document.data().count
                    let data = document.data()
                    var i = 1
                    var songArray = [Song]()
                    while (i <= count){
                        let id = "song\(i)"
                        if let song = data[id] as? [String: Any] {
                            let songName = song["songName"] as? String ?? "error"
                            let artistName = song["artistName"] as? String ?? ""
                            let coverName = song["coverName"] as? String ?? ""
                            let fileName = song["fileName"] as? String ?? ""
                            let lyrics = song["lyrics"] as? String ?? ""
                            songArray.append(Song(artistName, songName, coverName, fileName, lyrics))
                        }
                        i += 1
                    }
                    self.songs = songArray
                    ModelObject.sharedIntance.songs = self.songs
                }
                else if(document.documentID == "playlists"){
                    let playlistCount:Int = document.data().count
                    let data = document.data()
                    var i = 1
                    var playlistArray = [Playlist]()
                    while(i <= playlistCount){
                        let id = "playlist\(i)"
                        if let playlist = data[id] as? [String : Any]{
                            let name = playlist["name"] as? String ?? ""
                            let posterName = playlist["posterName"] as? String ?? ""
                            var songArray = [Song]()
                            if let songs = playlist["songs"] as? [String:Any] {
                                let songCount = songs.count
                                var j = 1;
                                while(j <= songCount){
                                    let songId = "song\(j)"
                                    if let song = songs[songId] as? [String: Any]{
                                        let songName = song["songName"] as? String ?? "error"
                                        let artistName = song["artistName"] as? String ?? ""
                                        let coverName = song["coverName"] as? String ?? ""
                                        let fileName = song["fileName"] as? String ?? ""
                                        let lyrics = song["lyrics"] as? String ?? ""
                                        songArray.append(Song(artistName, songName, coverName, fileName, lyrics))
                                    }
                                    j += 1
                                }
                            }
                            playlistArray.append(Playlist(name, posterName, songArray))
                        }
                        i += 1
                    }
                    self.playlists = playlistArray
                    ModelObject.sharedIntance.playlists = self.playlists
                }
            }
            self.table.reloadData()
            if let playerVC = self.playerVC{
                if let playerView = ModelObject.sharedIntance.miniPlayerView{
                    if(playerView.isHidden == false && self.mainView.isHidden == true){
                        self.mainView.isHidden = false
                    }
                    self.miniPlayer?.configure(playerVC.songs[playerVC.position], self.mainView, playerVC.player!)
                }
            }
        }
    }
    @objc func gestureRecognized(_ gesture: UITapGestureRecognizer){
        if let playerVC = playerVC{
            present(playerVC, animated: true, completion: nil)
        }else{
            guard let vc = storyboard?.instantiateViewController(identifier: "player")
                    as? PlayerViewController else{
                return
            }
            present(vc, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        position = indexPath.row
        guard let playerInstanceVC = storyboard?.instantiateViewController(identifier: "player") as?
                PlayerViewController else {
            return
        }
        if let playerVC = playerVC{
            playerVC.player?.stop()
            playerVC.player = nil
        }
        playerVC = playerInstanceVC
        playerVC?.songs = self.songs
        playerVC?.position = indexPath.row
        playerVC?.miniPlayerView = mainView
        playerVC?.miniPlayer = miniPlayer
        if let _ = ModelObject.sharedIntance.miniPlayerView{
            ModelObject.sharedIntance.miniPlayerView?.isHidden = true
        }
        ModelObject.sharedIntance.miniPlayerView = self.mainView
        present(playerVC ?? playerInstanceVC, animated: true, completion: nil)
        let gestureRecognizer = UITapGestureRecognizer(target: self,
                                                       action: #selector(gestureRecognized(_ :)))
        gestureRecognizer.numberOfTapsRequired = 1
        gestureRecognizer.numberOfTouchesRequired = 1
        mainView.addGestureRecognizer(gestureRecognizer)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "nowPlayingBar"){
            if let destination = segue.destination as? MiniPlayerViewController {
                miniPlayer = destination
            }
        }
        if(segue.identifier == "playlistViewController"){
            let playlistVC: PlaylistViewController = segue.destination as! PlaylistViewController
            if let playlist = playlist {
                if let playerVC = playerVC{
                    if let _ = mainView{
                        ModelObject.sharedIntance.miniPlayerView = mainView
                    }
                    playlistVC.delegate = self
                    playlistVC.configure(playlist, playerVC)
                }
                else{
                    playlistVC.delegate = self
                    playlistVC.configure(playlist)
                }
            }
        }
        
    }
    
    func configure(_ playerVC:PlayerViewController){
        self.playerVC = playerVC
    }
    
    func pushToSuperView(withData: Playlist) {
        playlist = withData
        performSegue(withIdentifier: "playlistViewController", sender: self)
    }
    
    func pushToSuperView(withViewController: PlayerViewController) {
        self.playerVC = withViewController
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == 0){
            let playlistsCell = tableView.dequeueReusableCell(withIdentifier: PlaylistTableViewCell.identifier, for: indexPath) as! PlaylistTableViewCell
            let playlists = playlists
            playlistsCell.configure(playlists)
            playlistsCell.delegate = self
            return playlistsCell
        }
        let musicCell = tableView.dequeueReusableCell(withIdentifier: MusicCell.identifier, for: indexPath) as! MusicCell
        musicCell.configure(songs[indexPath.row])
        return musicCell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            tableView.beginUpdates()
            let song = "song\(indexPath.row+1)"
            docRef.document(song).delete(){er in
                if let _ = er{
                    print("error Occured")
                }
                else{
                    print("Succesfully deleted")
                }
            }
            docRef.document("songs").setData([song: FieldValue.delete()], merge: true)
            songs.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.row == 0){
            return 240
        }
        return 60
    }
}
