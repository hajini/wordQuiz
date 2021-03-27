//
//  ScoreVC.swift
//  wordQuiz
//
//  Created by Hajin Jeong on 2021/01/28.
//

import UIKit

class ScoreVC: UIViewController {

    @IBOutlet var title01: UILabel!
    @IBOutlet var title02: UILabel!
    @IBOutlet var title03: UILabel!
    
    static var finalScore = 0
    static var finalSkip = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title01.font = UIFont(name: "GodoM", size: 40)!
        title02.font = UIFont(name: "GodoM", size: 20)!
        title03.font = UIFont(name: "GodoM", size: 20)!
        
        if ViewController.second == "60s" {
            title01.text = "60초가 모두 지났어요"
        } else {
            title01.text = "30초가 모두 지났어요"
        }
        
        title02.text = "\(ScoreVC.finalScore)문제를 맞추셨습니다"
        title03.text = "(포기한 문제 : \(ScoreVC.finalSkip))"
        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func backToHomeBtnTap(_ sender: Any) {
        
        view.window?.rootViewController?.dismiss(animated: false, completion: {
        })
    }
    
    
    
}
