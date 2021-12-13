//
//  MusicDAO.swift
//  BenyamV2.0
//
//  Created by Raim on 05.12.2021.
//

import Foundation
class MusicDAO{
    static let shared = MusicDAO()
    var songs:[Song] = [Song("Ed Sheeran", "Shivers", "cover1"),
                        Song("Kendrick Lamar", "Humble", "cover2"),
                        Song("JJ Lin", "Lose Control", "cover3"),
                        Song("Ed Sheeran", "Shivers", "cover1"),
                        Song("Kendrick Lamar", "Humble", "cover2"),
                        Song("JJ Lin", "Lose Control", "cover3"),
                        Song("Ed Sheeran", "Shivers", "cover1"),
                        Song("Kendrick Lamar", "Humble", "cover2"),
                        Song("JJ Lin", "Lose Control", "cover3"),
                        Song("City Of The Sun", "Everything", "cover4"),
                        Song("Hans Zimmer", "Time", "cover5"),
                        Song("City Of The Sun", "Everything", "cover4"),
                        Song("Hans Zimmer", "Time", "cover5"),
                        Song("City Of The Sun", "Everything", "cover4"),
                        Song("Hans Zimmer", "Time", "cover5")]
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
