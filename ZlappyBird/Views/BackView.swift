//
//  BackView.swift
//  ZlappyBird
//
//  Created by Dmitry Victorovich on 03.04.2022.
//

import Foundation
import UIKit

class BackView {

    private var isInitial = true
    
    private let backgroundImageView = UIImageView()
    private let backImageModel = BackImage()

    func addImageToView(_ view: UIView, completion: @escaping (UIImageView) -> Void) {

        if isInitial {
            isInitial.toggle()
            guard let view = view as? View else { return }
            view.addSubview(backgroundImageView)
            view.sendSubviewToBack(backgroundImageView)
            backgroundImageView.frame = CGRect(x: 0,
                                               y: 0,
                                               width: view.bounds.width * 2,
                                               height: view.bounds.height)
            backgroundImageView.image = UIImage(named: backImageModel.imageName)
        } else {
            backgroundImageView.frame.origin = CGPoint(x: 0,
                                                       y: 0)
        }
        
        completion(backgroundImageView)
    }
}
