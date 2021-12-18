//
//  Song.swift
//  BenyamV2.0
//
//  Created by Raim on 30.11.2021.
//

import Foundation
class Song{
    let artistName:String
    let songName:String
    let coverName:String
    let fileName:String
    init(_ artistName:String, _ songName:String, _ coverName:String, _ fileName:String){
        self.artistName = artistName
        self.songName = songName
        self.coverName = coverName
        self.fileName = fileName
    }
}
