//
//  NestedCellHandler.swift
//  BenyamV2.0
//
//  Created by Raim on 09.12.2021.
//

import Foundation
import UIKit
protocol NestedCellHandler:class {
    func pushToSuperView(withData:Playlist)
}
protocol NestedViewControllerHandler:class{
    func pushToSuperView(withViewController:PlayerViewController)
}
