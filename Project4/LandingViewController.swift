//
//  LandingViewController.swift
//  Project4
//
//  Created by Evan Zhao on 4/13/16.
//  Copyright © 2016 Evan Zhao. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {

    @IBOutlet weak var play: UIButton!
    @IBOutlet weak var diff: UISegmentedControl!

    var difficulty: Double!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let slider = diff.selectedSegmentIndex
        if slider == 0 {
            difficulty = 1
        }   else if slider == 1 {
            difficulty = 0.08
        }
        if let destination = segue.destination as? ViewController {
            destination.difficulty = self.difficulty
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
