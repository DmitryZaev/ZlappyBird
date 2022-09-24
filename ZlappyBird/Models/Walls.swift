//
//  Walls.swift
//  ZlappyBird
//
//  Created by Dmitry Victorovich on 01.04.2022.
//

import Foundation

private protocol Wall {
    var heigth: Int { get }
    var width: Int { get }
    var imageName: String { get }
}

struct TopWall: Wall {
    var heigth: Int
    let width = 14
    let imageName = "topStick"
}

struct BottomWall: Wall {
    var heigth: Int
    let width = 14
    let imageName = "bottomStick"
}
