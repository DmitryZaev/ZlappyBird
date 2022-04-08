//
//  BirdView.swift
//  ZlappyBird
//
//  Created by Dmitry Victorovich on 01.04.2022.
//

import Foundation
import UIKit

class BirdView: UIView {
    
    private let birdModel = Bird()
    
    func addBirdToView(_ view: UIView) {
        
        let birdImageView = UIImageView(image: .init(named: birdModel.imageName))
        birdImageView.frame.size = CGSize(width: birdModel.width,
                                          height: birdModel.height)
        birdImageView.frame.origin = CGPoint(x: view.frame.width / 4,
                                             y: view.frame.height / 2)
        birdImageView.layer.cornerRadius = CGFloat(birdModel.height / 2)
        birdImageView.layer.masksToBounds = true
        
        view.addSubview(birdImageView)
        
        guard let view = view as? View else { return }
        view.birdImageView = birdImageView
        view.collision.addItem(birdImageView)
        view.collisionForBird.addItem(birdImageView)
        view.gravityForBird.addItem(birdImageView)
    }
}
