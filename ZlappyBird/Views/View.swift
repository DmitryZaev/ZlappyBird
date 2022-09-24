//
//  View.swift
//  ZlappyBird
//
//  Created by Dmitry Victorovich on 01.04.2022.
//

import UIKit

class View: UIView {
    
    let animator = UIDynamicAnimator()
    let horizontalGravity = UIGravityBehavior()
    let gravityForBird = UIPushBehavior(items: [], mode: .continuous)
    let collision = UICollisionBehavior()
    let collisionForBird = UICollisionBehavior()
    
    enum BirdGravityDirection {
        case Up
        case Down
    }
    
    var backgroundMoveTimer: Timer!
    var wallCreateTimer: Timer!
    
    var birdImageView: UIImageView!
    var scoreLabel: UILabel!
    var restartButton: UIButton!
    
    var isAnimating = true

    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0,
                                 y: 0,
                                 width: [UIScreen.main.bounds.width, UIScreen.main.bounds.height].sorted(by: <)[1],
                                 height: [UIScreen.main.bounds.width, UIScreen.main.bounds.height].sorted(by: <)[0]))
                   
       self.animatorConfigure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        guard scoreLabel != nil else { return }
        bringSubviewToFront(scoreLabel)
        
        guard restartButton != nil else { return }
        bringSubviewToFront(restartButton)
        
        guard birdImageView != nil else { return }
        if birdImageView.frame.maxX <= self.frame.origin.x, isAnimating {
            stopAnimation()
        }
    }
    
    
    private func animatorConfigure() {
        //collision.translatesReferenceBoundsIntoBoundary = true
        collision.collisionDelegate = self
        animator.addBehavior(collision)
        
        
        collisionForBird.translatesReferenceBoundsIntoBoundary = true
        collisionForBird.addBoundary(withIdentifier: "topBoundary" as NSCopying,
                                     from: CGPoint(x: self.bounds.minX,
                                                   y: 0),
                                     to: CGPoint(x: self.bounds.maxX,
                                                 y: 0))
        collisionForBird.addBoundary(withIdentifier: "bottomBoundary" as NSCopying,
                                     from: CGPoint(x: self.bounds.minX,
                                                   y: self.bounds.maxY),
                                     to: CGPoint(x: self.bounds.maxX,
                                                 y: self.bounds.maxY))
        collisionForBird.addBoundary(withIdentifier: "rightBoundary" as NSCopying,
                                     from: CGPoint(x: self.bounds.maxX,
                                                   y: 0),
                                     to: CGPoint(x: self.bounds.maxX,
                                                 y: self.bounds.maxY))
        collisionForBird.collisionDelegate = self
        animator.addBehavior(collisionForBird)
        
        setBirdGravityDirection(direction: .Down)
        animator.addBehavior(gravityForBird)
        
        horizontalGravity.gravityDirection = .init(dx: -1, dy: 0)
        horizontalGravity.magnitude = 0.01
        animator.addBehavior(horizontalGravity)
    }
    
    func setBirdGravityDirection(direction: BirdGravityDirection) {
        switch direction {
        case .Up:
            gravityForBird.pushDirection = CGVector(dx: 0, dy: -1)
        case .Down:
            gravityForBird.pushDirection = CGVector(dx: 0, dy: 1)
        }
        gravityForBird.magnitude = 0.08
    }
    
    func invertBirdGravity(gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .began:
            setBirdGravityDirection(direction: .Up)
        case .ended:
            setBirdGravityDirection(direction: .Down)
        default: break
        }
    }
    
    func stopAnimation() {
        isAnimating.toggle()
        backgroundMoveTimer?.invalidate()
        wallCreateTimer?.invalidate()
        animator.removeBehavior(horizontalGravity)
        animator.removeBehavior(gravityForBird)
        self.gestureRecognizers?.removeAll()
        
        UIView.animate(withDuration: 1,
                       animations: {
            guard let scoreLabel = self.scoreLabel else { return }
            scoreLabel.frame.size = CGSize(width: scoreLabel.frame.size.width * 4,
                                                height: scoreLabel.frame.size.height * 4)
            scoreLabel.layer.borderWidth *= 3
            scoreLabel.layer.cornerRadius *= 4
            scoreLabel.center = self.center
            scoreLabel.frame.origin.y  -= 100
            scoreLabel.font = scoreLabel.font.withSize(120)
        }, completion: { _ in
            UIView.animate(withDuration: 1,
                           animations: {
                guard let restartButton = self.restartButton else { return }
                restartButton.frame = restartButton.frame.offsetBy(dx: 0, dy: -200)
            })
        })
    }
}

extension View: UICollisionBehaviorDelegate {
    
    enum Vibration {
        static let soft = UIImpactFeedbackGenerator(style: .soft)
        static let heavy = UIImpactFeedbackGenerator(style: .heavy)
    }
    
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item1: UIDynamicItem, with item2: UIDynamicItem, at p: CGPoint) {
        
        Vibration.heavy.impactOccurred()
    }
    
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, at p: CGPoint) {
        
        Vibration.soft.impactOccurred()
    }
}
