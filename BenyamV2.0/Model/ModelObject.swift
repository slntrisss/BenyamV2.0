//
//  ModelObject.swift
//  BenyamV2.0
//
//  Created by Raim on 20.12.2021.
//

import Foundation
import UIKit
class ModelObject{
    static let sharedIntance = ModelObject()
    var VC:PlayerViewController?
    weak var miniPlayerView:UIView?
    var songs:[Song] = []
    var playlists = [Playlist]()
}
