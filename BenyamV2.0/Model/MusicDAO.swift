//
//  MusicDAO.swift
//  BenyamV2.0
//
//  Created by Raim on 05.12.2021.
//

import Foundation
class MusicDAO{
    static let shared = MusicDAO()
    var songs:[Song] = [Song("Ed Sheeran", "song1", "cover1"),
                        Song("Kendrick Lamar", "song2", "cover2"),
                        Song("JJ Lin", "song3", "cover3"),
                        Song("Ed Sheeran", "song4", "cover1"),
                        Song("Kendrick Lamar", "song5", "cover2"),
                        Song("JJ Lin", "song1", "cover3"),
                        Song("Ed Sheeran", "song2", "cover1"),
                        Song("Kendrick Lamar", "song3", "cover2"),
                        Song("JJ Lin", "song4", "cover3"),
                        Song("City Of The Sun", "song5", "cover4"),
                        Song("Hans Zimmer", "song2", "cover5"),
                        Song("City Of The Sun", "song1", "cover4"),
                        Song("Hans Zimmer", "song4", "cover5"),
                        Song("City Of The Sun", "song3", "cover4"),
                        Song("Hans Zimmer", "song5", "cover5")]
    var playlists:[Playlist] = [Playlist("Awesome mix", "cover1", "05.12.2021", [Song("Ed Sheeran", "Shivers", "cover1"),
                                                                              Song("Kendrick Lamar", "Humble", "cover2"),
                                                                              Song("JJ Lin", "Lose Control", "cover3"),
                                                                              Song("Ed Sheeran", "Shivers", "cover1"),
                                                                              Song("Kendrick Lamar", "Humble", "cover2"),
                                                                              Song("JJ Lin", "Lose Control", "cover3"),
                                                                              Song("Ed Sheeran", "Shivers", "cover1"),
                                                                              Song("Kendrick Lamar", "Humble", "cover2"),
                                                                              Song("JJ Lin", "Lose Control", "cover3"),]),
                                Playlist("Classic", "cover2", "12.09.2020", [Song("City Of The Sun", "Everything", "cover4"),
                                                                              Song("Hans Zimmer", "Time", "cover5"),
                                                                              Song("City Of The Sun", "Everything", "cover4"),
                                                                              Song("Hans Zimmer", "Time", "cover5"),
                                                                              Song("City Of The Sun", "Everything", "cover4"),
                                                                              Song("Hans Zimmer", "Time", "cover5")]),
                                Playlist("Classic", "cover2", "12.09.2020", [Song("City Of The Sun", "Everything", "cover4"),
                                                                              Song("Hans Zimmer", "Time", "cover5"),
                                                                              Song("City Of The Sun", "Everything", "cover4"),
                                                                              Song("Hans Zimmer", "Time", "cover5"),
                                                                              Song("City Of The Sun", "Everything", "cover4"),
                                                                              Song("Hans Zimmer", "Time", "cover5")]),
                                Playlist("Classic", "cover2", "12.09.2020", [Song("City Of The Sun", "Everything", "cover4"),
                                                                              Song("Hans Zimmer", "Time", "cover5"),
                                                                              Song("City Of The Sun", "Everything", "cover4"),
                                                                              Song("Hans Zimmer", "Time", "cover5"),
                                                                              Song("City Of The Sun", "Everything", "cover4"),
                                                                              Song("Hans Zimmer", "Time", "cover5")]),
                                Playlist("Classic", "cover2", "12.09.2020", [Song("City Of The Sun", "Everything", "cover4"),
                                                                              Song("Hans Zimmer", "Time", "cover5"),
                                                                              Song("City Of The Sun", "Everything", "cover4"),
                                                                              Song("Hans Zimmer", "Time", "cover5"),
                                                                              Song("City Of The Sun", "Everything", "cover4"),
                                                                              Song("Hans Zimmer", "Time", "cover5")])]
    
}
