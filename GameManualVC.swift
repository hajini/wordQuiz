//
//  GameManualVC.swift
//  wordQuiz
//
//  Created by Hajin Jeong on 2021/01/28.
//

import UIKit

class GameManualVC: UIViewController {

    @IBOutlet var nextBtn: UIButton!
    @IBOutlet var titleLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        titleLbl.font = UIFont(name: "GodoM", size: 40)!
        
        nextBtn.setTitle("다음", for: .normal)
        nextBtn.titleLabel!.font = UIFont(name: "GodoM", size: 20)!
    }
    
    @IBAction func nextBtnTap(_ sender: Any) {
        
        moveToNext()
    }
    
    
    
    func moveToNext() {
        let profilesb = UIStoryboard(name: "Main", bundle: nil)
        let VC = profilesb.instantiateViewController(withIdentifier: "gameScreen")
        VC.modalPresentationStyle = .fullScreen
        present(VC, animated: true, completion: nil)
    }

}
