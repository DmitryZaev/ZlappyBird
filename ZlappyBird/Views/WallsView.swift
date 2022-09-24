//
//  WallsView.swift
//  ZlappyBird
//
//  Created by Dmitry Victorovich on 01.04.2022.
//

import Foundation
import UIKit

class WallsView {
    
    var topWallModel: TopWall!
    
    var bottomWallModel: BottomWall!
    
    func createWalls(onView view: UIView) {
        
        let freeSpace = Int.random(in: 50...90)
        let viewHeight = Int(view.bounds.height)
        let viewWidht = Int(view.bounds.width)
        let maxHeightForTopWall = viewHeight - freeSpace - 1
        let heightForTopWall = Int.random(in: 1...maxHeightForTopWall)
        topWallModel = TopWall(heigth: heightForTopWall)
        
        let topWallImageView = UIImageView(frame: CGRect(x: viewWidht,
                                                     y: -5,
                                                     width: topWallModel.width,
                                                     height: topWallModel.heigth))
        topWallImageView.image = UIImage(named: topWallModel.imageName)
        topWallImageView.layer.cornerRadius = 5
        topWallImageView.layer.masksToBounds = true
        view.addSubview(topWallImageView)
        
        
        let heightForBottomWall = viewHeight - heightForTopWall - freeSpace
        bottomWallModel = BottomWall(heigth: heightForBottomWall)
        let originY = viewHeight - bottomWallModel.heigth + 5
        
        let bottomWallImageView = UIImageView(frame: CGRect(x: viewWidht,
                                                            y: originY,
                                                            width: bottomWallModel.width,
                                                            height: bottomWallModel.heigth))
        bottomWallImageView.image = UIImage(named: bottomWallModel.imageName)
        bottomWallImageView.layer.cornerRadius = 5
        bottomWallImageView.layer.masksToBounds = true
        view.addSubview(bottomWallImageView)
        
        guard let view = view as? View else { return }
        view.collision.addItem(topWallImageView)
        view.collision.addItem(bottomWallImageView)
        view.horizontalGravity.addItem(topWallImageView)
        view.horizontalGravity.addItem(bottomWallImageView)
    }
}
