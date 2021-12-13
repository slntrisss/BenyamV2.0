//
//  Playlist.swift
//  BenyamV2.0
//
//  Created by Raim on 30.11.2021.
//

import Foundation
class Playlist{
    var name:String
    var posterName:String
    var lastUpdated: String
    var songs:[Song]
    init(_ name:String, _ posterName:String, _ lastUpdated:String, _ songs:[Song]){
        self.name = name
        self.posterName = posterName
        self.lastUpdated = lastUpdated
        self.songs = songs
    }
}
