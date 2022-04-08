//
//  Score.swift
//  ZlappyBird
//
//  Created by Dmitry Victorovich on 05.04.2022.
//

import Foundation

struct Score {
    let fontName = "Kefa Regular"
    let fontSize = 30
    var score = 0 {
        didSet {
            text = String(score)
        }
    }
    var text = "0"
}
