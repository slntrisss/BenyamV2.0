//
//  MusicDAO.swift
//  BenyamV2.0
//
//  Created by Raim on 05.12.2021.
//

import Foundation
import Firebase
class MusicDAO{
    var docRef: DocumentReference!
    public var songs:[Song] = []
    var playlists:[Playlist] = []
    static let shared = MusicDAO()
    func loadData(completion: @escaping ([Song]?, Error?) -> Void){
        Firestore.firestore().collection("music").getDocuments {snapshot, error  in
            guard let snapshot = snapshot, error == nil else{return}
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
                    completion(self.songs, nil)
                }
                else if(document.documentID == "playlists"){
                    let name = document.data()["name"] as? String ?? ""
                    let posterName = document.data()["posterName"] as? String ?? ""
                    let songs = document.data()["songs"] as? [Song] ?? []
                    self.playlists.append(Playlist(name, posterName, songs))
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
