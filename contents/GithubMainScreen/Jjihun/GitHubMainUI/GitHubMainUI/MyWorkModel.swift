//
//  MyWorkModel.swift
//  GitHubMainUI
//
//  Created by 정지훈 on 2022/11/04.
//

import Foundation
import UIKit.UIColor
struct MyWorkModel : Codable {
    let imageName: String
    let name: String
    let colorName: UIColor
}

extension MyWorkModel {
    static let list: [MyWorkModel] = [
        MyWorkModel(imageName: "smallcircle.circle", name: "Issues", colorName: UIColor.green),
        MyWorkModel(imageName: "arrow.triangle.pull", name: "Pull Requests", colorName: UIColor.blue),
        MyWorkModel(imageName: "bubble.left.and.bubble.right", name: "Discussions", colorName: UIColor.purple),
        MyWorkModel(imageName: "folder", name: "Repositories", colorName: UIColor.black),
        MyWorkModel(imageName: "building.2", name: "Organizations", colorName: UIColor.orange),
        MyWorkModel(imageName: "star", name: "Starred", colorName: UIColor.yellow)
    ]
}
