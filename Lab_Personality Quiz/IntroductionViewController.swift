//
//  IntroductionViewController.swift
//  Lab_Personality Quiz
//
//  Created by 曹家瑋 on 2023/10/2.
//

import UIKit

class IntroductionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    

    @IBAction func unwindToQuizIntroduction(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
    }

}
