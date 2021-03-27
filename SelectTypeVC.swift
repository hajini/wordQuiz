//
//  SelectTypeVC.swift
//  wordQuiz
//
//  Created by Hajin Jeong on 2021/01/28.
//

import UIKit

class SelectTypeVC: UIViewController {

    @IBOutlet var wordBtn: UIButton!
    @IBOutlet var picBtn: UIButton!
    
    static var typeSelcetor = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func wordBtnTap(_ sender: Any) {
        SelectTypeVC.typeSelcetor = "word"
        moveToNext()
    }
    @IBAction func picBtnTap(_ sender: Any) {
        SelectTypeVC.typeSelcetor = "pic"
        moveToNext()
    }
    
    @IBAction func backToHomeBtnTap(_ sender: Any) {
        view.window?.rootViewController?.dismiss(animated: false, completion: {
        })
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func moveToNext() {
        let profilesb = UIStoryboard(name: "Main", bundle: nil)
        let VC = profilesb.instantiateViewController(withIdentifier: "gameManual")
        VC.modalPresentationStyle = .fullScreen
        present(VC, animated: true, completion: nil)
    }
}
