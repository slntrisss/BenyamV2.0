//
//  MusicDAO.swift
//  BenyamV2.0
//
//  Created by Raim on 05.12.2021.
//

import Foundation
import Firebase
class MusicDAO{
    var docRef: CollectionReference!
    public var songs:[Song] = []
    var playlists:[Playlist] = []
    static let shared = MusicDAO()
    func loadData(){
        docRef = Firestore.firestore().collection("music")
        docRef.getDocuments { snapshot, error in
            guard let snapshot = snapshot else{return}
            for document in snapshot.documents {
                if(document.documentID == "songs"){
                    let count:Int = document.data().count
                    let data = document.data()
                    var i = 1
                    while (i <= count){
                        let id = "song\(i)"
                        if let song = data[id] as? [String: Any] {
                            let songName = song["songName"] as? String ?? "error"
                            let artistName = song["artistName"] as? String ?? ""
                            let coverName = song["coverName"] as? String ?? ""
                            let fileName = song["fileName"] as? String ?? ""
                            self.songs.append(Song(artistName, songName, coverName, fileName))
                        }
                        i += 1
                    }
                }
                else if(document.documentID == "playlists"){
                    let playlistCount:Int = document.data().count
                    let data = document.data()
                    var i = 1
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
                                        songArray.append(Song(artistName, songName, coverName, fileName))
                                    }
                                    j += 1
                                }
                            }
                            self.playlists.append(Playlist(name, posterName, songArray))
                        }
                        i += 1
                    }
                }
            }
        }
    }
    //    var songs:[Song] = [Song("Ed Sheeran", "Control_The_World", "cover1"),
    //                        Song("Kendrick Lamar", "Humble", "cover2"),
    //                        Song("JJ Lin", "Just_For_Me", "cover3"),
    //                        Song("Ed Sheeran", "Lose_Control", "cover1"),
    //                        Song("Kendrick Lamar", "Shivers", "cover2"),
    //                        Song("JJ Lin", "Control_The_World", "cover3"),
    //                        Song("Ed Sheeran", "Humble", "cover1"),
    //                        Song("Kendrick Lamar", "Just_For_Me", "cover2"),
    //                        Song("JJ Lin", "Lose_Control", "cover3"),
    //                        Song("City Of The Sun", "Shivers", "cover4"),
    //                        Song("Hans Zimmer", "Humble", "cover5"),
    //                        Song("City Of The Sun", "Control_The_World", "cover4"),
    //                        Song("Hans Zimmer", "Lose_Control", "cover5"),
    //                        Song("City Of The Sun", "Just_For_Me", "cover4"),
    //                        Song("Hans Zimmer", "Shivers", "cover5")]
    //    var playlists:[Playlist] = [Playlist("Awesome mix", "cover1", [Song("Ed Sheeran", "Shivers", "cover1"),
    //                                                                              Song("Kendrick Lamar", "Humble", "cover2"),
    //                                                                              Song("JJ Lin", "Lose Control", "cover3"),
    //                                                                              Song("Ed Sheeran", "Shivers", "cover1"),
    //                                                                              Song("Kendrick Lamar", "Humble", "cover2"),
    //                                                                              Song("JJ Lin", "Lose Control", "cover3"),
    //                                                                              Song("Ed Sheeran", "Shivers", "cover1"),
    //                                                                              Song("Kendrick Lamar", "Humble", "cover2"),
    //                                                                              Song("JJ Lin", "Lose Control", "cover3"),]),
    //                                Playlist("Classic", "cover2",  [Song("City Of The Sun", "Everything", "cover4"),
    //                                                                              Song("Hans Zimmer", "Time", "cover5"),
    //                                                                              Song("City Of The Sun", "Everything", "cover4"),
    //                                                                              Song("Hans Zimmer", "Time", "cover5"),
    //                                                                              Song("City Of The Sun", "Everything", "cover4"),
    //                                                                              Song("Hans Zimmer", "Time", "cover5")]),
    //                                Playlist("Classic", "cover2",  [Song("City Of The Sun", "Everything", "cover4"),
    //                                                                              Song("Hans Zimmer", "Time", "cover5"),
    //                                                                              Song("City Of The Sun", "Everything", "cover4"),
    //                                                                              Song("Hans Zimmer", "Time", "cover5"),
    //                                                                              Song("City Of The Sun", "Everything", "cover4"),
    //                                                                              Song("Hans Zimmer", "Time", "cover5")]),
    //                                Playlist("Classic", "cover2",  [Song("City Of The Sun", "Everything", "cover4"),
    //                                                                              Song("Hans Zimmer", "Time", "cover5"),
    //                                                                              Song("City Of The Sun", "Everything", "cover4"),
    //                                                                              Song("Hans Zimmer", "Time", "cover5"),
    //                                                                              Song("City Of The Sun", "Everything", "cover4"),
    //                                                                              Song("Hans Zimmer", "Time", "cover5")]),
    //                                Playlist("Classic", "cover2",  [Song("City Of The Sun", "Everything", "cover4"),
    //                                                                              Song("Hans Zimmer", "Time", "cover5"),
    //                                                                              Song("City Of The Sun", "Everything", "cover4"),
    //                                                                              Song("Hans Zimmer", "Time", "cover5"),
    //                                                                              Song("City Of The Sun", "Everything", "cover4"),
    //                                                                              Song("Hans Zimmer", "Time", "cover5")])]
}
