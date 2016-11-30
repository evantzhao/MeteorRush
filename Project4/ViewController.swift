//
//  ViewController.swift
//  Project4
//
//  Created by Evan Zhao on 4/11/16.
//  Copyright © 2016 Evan Zhao. All rights reserved.

// Perhaps create a c++ object for the spaceship, and then create a pointing system such that getting hit by an asteroid deducts a set amount of Health. When you reach zero, the game ends. Can probably add in a leaderboard as well.
//

import UIKit

class ViewController: UIViewController, UICollisionBehaviorDelegate {
    
    @IBOutlet weak var playAgain: UIButton!
    @IBOutlet var panning: UIPanGestureRecognizer!
    @IBOutlet weak var ship: UIView!
    @IBOutlet weak var score: UILabel!
    @IBOutlet var healthLabel: UILabel!
    @IBOutlet var deathLabel: UILabel!
    
    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var collision: UICollisionBehavior!
    var lastScore: Int!
    var timer: Timer!
    var scoreCounter: Int!
    var difficulty: Double!

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scoreCounter = 0
        setHealth(5);
        healthLabel.text = String(getHealth());
        // Setting up the animator
        animator = UIDynamicAnimator(referenceView: view)
        
        // Setting up other behaviors (Gravity, collision, timer)
        collision = UICollisionBehavior(items: [ship])
        collision.collisionDelegate = self
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
        
        gravity = UIGravityBehavior()
        animator.addBehavior(gravity)
        
        timer = Timer(timeInterval: difficulty, target: self, selector: #selector(ViewController.timerFired(_:)), userInfo: nil, repeats: true)
        RunLoop.main.add(timer, forMode: RunLoopMode.commonModes)
    }
    
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, at p: CGPoint) {
        if !item.isEqual(ship) && p.y > 700 {
            gravity.removeItem(item)
            collision.removeItem(item)
            for see in view.subviews {
                if see.isEqual(item) {
                    see.removeFromSuperview()
                    scoreCounter = scoreCounter+1
                    addHealth(1);
                    healthLabel.text = String(getHealth());
                    score.text = String(scoreCounter)
                }
            }
        }
    }
    
    
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item1: UIDynamicItem, with item2: UIDynamicItem, at p: CGPoint) {
        subtractHealth(10);
        healthLabel.text = String(getHealth());
        if (item1.isEqual(ship) || item2.isEqual(ship)) && isDead() {
            endGame()
        }
    }
    
    func endGame() {
        deathLabel.text = "lmao u died bro.";
        timer.invalidate()
        for see in view.subviews {
            if !see.isEqual(score){
                gravity.removeItem(see)
                collision.removeItem(see)
            }
        }
        panning.isEnabled = false
        playAgain.isHidden = false
    }
    
    func backToMain() {
        self.performSegue(withIdentifier: "gameOver", sender: self)
    }
    
    func timerFired(_ timer: Timer) {
        let dropPos = Int(self.view.frame.width-5)
        dropAsteroid(dropPos)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gameOver" {
            let destViewController : LandingViewController = segue.destination as! LandingViewController
            if lastScore == nil {
                destViewController.score = scoreCounter
            }
            else if (scoreCounter > lastScore) {
                destViewController.score = scoreCounter
            } else {
                destViewController.score = lastScore
            }
            
        }
    }
    
    func dropAsteroid(_ pos: Int) {
        let asteroidView = UIView(frame: CGRect(x: 50, y: 50, width: 30, height: 30))
        asteroidView.backgroundColor = UIColor.black
        // Creating the new generation point for the asteroid.
        asteroidView.center = CGPoint(x: Int(arc4random_uniform(UInt32(pos))+5), y: 16)
        // Asteroid is now visible!
        view.addSubview(asteroidView)
        
        // Gravity
        gravity.addItem(asteroidView)
        // Collision Behavior
        collision.addItem(asteroidView)
    }
    
    @IBAction func dragShip(_ sender: UIPanGestureRecognizer) {
        let shipView = sender.view!
        let s = sender.translation(in: view)
        shipView.center = CGPoint(x: shipView.center.x + s.x, y: shipView.center.y + s.y)
        sender.setTranslation(CGPoint.zero, in: nil)
        animator.updateItem(usingCurrentState: shipView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playAgain.addTarget(self, action: #selector(ViewController.backToMain as (ViewController) -> () -> ()), for: .touchUpInside)
        playAgain.isHidden = true;
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

