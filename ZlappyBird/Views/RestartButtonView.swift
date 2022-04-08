//
//  RestartButtonView.swift
//  ZlappyBird
//
//  Created by Dmitry Victorovich on 05.04.2022.
//

import Foundation
import UIKit

class RestartButtonView {
    
    private let restartImg = RestartImage()
    
    func addButtonToView(_ view: UIView, comletion: (UIButton) -> Void) {
        
        let restartButton = UIButton()
        
        let buttonSize = view.bounds.height / 4
        
        restartButton.frame.size = CGSize(width: buttonSize,
                                          height: buttonSize)
        restartButton.center = view.center
        restartButton.frame.origin.y = restartButton.frame.origin.y + (view.bounds.height / 2) + 100
        
        restartButton.layer.cornerRadius = buttonSize / 2
        restartButton.layer.shadowColor = UIColor.orange.cgColor
        restartButton.layer.shadowPath = CGPath(roundedRect: CGRect(x: -20,
                                                                    y: -20,
                                                                    width: buttonSize + 40,
                                                                    height: buttonSize + 40),
                                                cornerWidth: 60,
                                                cornerHeight: 60,
                                                transform: nil)
        restartButton.layer.shadowRadius = 30
        restartButton.layer.shadowOpacity = 1
        restartButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        let imageView = UIImageView.init(image: .init(systemName: restartImg.systemName))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        restartButton.addSubview(imageView)
        let imageViewSize = buttonSize * 3/4
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: imageViewSize),
            imageView.widthAnchor.constraint(equalToConstant: imageViewSize),
            imageView.centerXAnchor.constraint(equalTo: restartButton.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: restartButton.centerYAnchor)
        ])
        imageView.layer.cornerRadius = imageViewSize / 2
        imageView.layer.masksToBounds = true

        restartButton.backgroundColor = .yellow.withAlphaComponent(0.9)
        
        view.addSubview(restartButton)

        guard let view = view as? View else { return }
        view.restartButton = restartButton
        
        comletion(restartButton)
    }
}
