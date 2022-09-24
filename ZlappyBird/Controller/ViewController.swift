//
//  ViewController.swift
//  ZlappyBird
//
//  Created by Dmitry Victorovich on 01.04.2022.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var myView = View()
    private let backView = BackView()
    private let birdView = BirdView()
    private let wallView = WallsView()
    private let scoreView = ScoreView()
    private let restartButtonView = RestartButtonView()
    
    private var backgroundImageView: UIImageView!
    
    private var gesture = UILongPressGestureRecognizer()
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscapeLeft
    }
    
    override func loadView() {
        view = myView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackgroundImage()
        gestureConfigure()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        scoreView.addScoreLabelToView(view)
        birdView.addBirdToView(view)
        wallView.createWalls(onView: myView)
        createRestartButton()
        startCreateWalls()
    }
    
    @objc private func createWalls() {
        wallView.createWalls(onView: view)
        scoreView.updateScore()
    }
    
    private func gestureConfigure() {
        gesture = UILongPressGestureRecognizer(target: self, action: #selector(gestureFixed))
        gesture.minimumPressDuration = 0.01
        gesture.numberOfTapsRequired = 0
        myView.addGestureRecognizer(gesture)
    }
    
    @objc private func gestureFixed() {
        myView.invertBirdGravity(gesture: gesture)
    }
    
    private func startCreateWalls() {
        myView.wallCreateTimer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(createWalls), userInfo: nil, repeats: true)
    }
    
    private func setBackgroundImage() {
        backView.addImageToView(view) { imageView in
            self.backgroundImageView = imageView
            self.runBackgroundMoveTimer()
        }
    }
    
    private func runBackgroundMoveTimer() {
        guard let view = view as? View else { return }
        view.backgroundMoveTimer = Timer.scheduledTimer(timeInterval: 0.013, target: self, selector: #selector(self.moveBackgroundImageView), userInfo: nil, repeats: true)
    }
    
    @objc private func moveBackgroundImageView() {
        backgroundImageView.frame = backgroundImageView.frame.offsetBy(dx: -0.5,
                                                   dy: 0)
        if backgroundImageView.frame.origin.x <= -(view.bounds.width) {
            myView.backgroundMoveTimer.invalidate()
            self.setBackgroundImage()
        }
    }
    
    private func createRestartButton() {
        restartButtonView.addButtonToView(view) { button in
            button.addTarget(self, action: #selector(restartButtonDidPressed), for: .touchUpInside)
        }
    }
    
    @objc private func restartButtonDidPressed() {
        
        for view in myView.subviews {
            switch view {
            case backgroundImageView: break
            default: view.removeFromSuperview()
            }
        }
        
        for item in myView.collision.items {
            myView.collision.removeItem(item)
        }
        scoreView.scoreModel.score = 0
        runBackgroundMoveTimer()
        gestureConfigure()
        scoreView.addScoreLabelToView(view)
        birdView.addBirdToView(view)
        myView.setBirdGravityDirection(direction: .Down)
        myView.animator.addBehavior(myView.gravityForBird)
        myView.animator.addBehavior(myView.horizontalGravity)
        wallView.createWalls(onView: view)
        startCreateWalls()
        myView.isAnimating.toggle()
        createRestartButton()
    }
}
                                              
