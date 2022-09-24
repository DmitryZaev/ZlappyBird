//
//  ScoreView.swift
//  ZlappyBird
//
//  Created by Dmitry Victorovich on 05.04.2022.
//

import Foundation
import UIKit

class ScoreView {
    
    var scoreModel = Score() {
        didSet {
            scoreLabel.text = scoreModel.text
        }
    }
    
    private let scoreLabel = UILabel()
    
    func addScoreLabelToView(_ view: UIView) {
        
        guard let view = view as? View else { return }
        scoreLabel.frame.size = CGSize(width: view.bounds.width / 9,
                                       height: view.bounds.height / 9)
        scoreLabel.center = CGPoint(x: view.bounds.width - (scoreLabel.frame.width),
                                          y: 30)
        scoreLabel.text = scoreModel.text
        scoreLabel.font = UIFont(name: scoreModel.fontName,
                                 size: CGFloat(scoreModel.fontSize))
        scoreLabel.textAlignment = .center
        scoreLabel.textColor = UIColor.yellow
        scoreLabel.layer.cornerRadius = 20
        scoreLabel.layer.masksToBounds = true
        scoreLabel.layer.borderWidth = 5
        scoreLabel.layer.borderColor = UIColor.yellow.cgColor
        scoreLabel.backgroundColor = .red.withAlphaComponent(0.3)
        view.scoreLabel = scoreLabel
        view.addSubview(scoreLabel)
    }
    
    func updateScore() {
        
        scoreModel.score += 10
        scoreLabel.frame.size.width += 3
        scoreLabel.frame.size.height += 3
        scoreLabel.layer.borderWidth += 2
        
        UIView.animate(withDuration: 0.1, animations: {
            self.scoreLabel.frame.size.width -= 3
            self.scoreLabel.frame.size.height -= 3
            self.scoreLabel.layer.borderWidth -= 2
        })
    }
}
