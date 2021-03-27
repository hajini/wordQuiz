//
//  SettingVC.swift
//  wordQuiz
//
//  Created by Hajin Jeong on 2021/02/16.
//

import UIKit

class SettingVC: UIViewController {

    
    @IBOutlet var selectNationLbl: UILabel!
    @IBOutlet var timeLbl: UILabel!
    
    @IBOutlet var koreaBtn: UIButton!
    @IBOutlet var usaBtn: UIButton!
    @IBOutlet var chinaBtn: UIButton!
    @IBOutlet var japanBtn: UIButton!
    
    @IBOutlet var sixtyBtn: UIButton!
    @IBOutlet var thirtyBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if ViewController.nation == "kr" {
            selectNationLbl.text = "언어를 선택해 주세요"
            timeLbl.text = "게임 시간을 선택해 주세요"
            koreaBtn.setImage(UIImage(named:"korea1"), for: .normal)
        } else if ViewController.nation == "us" {
            selectNationLbl.text = "Please select a language"
            timeLbl.text = "Pleaes select a game time"
            usaBtn.setImage(UIImage(named:"usa1"), for: .normal)
        } else if ViewController.nation == "cn" {
            selectNationLbl.text = "请选择一种语言"
            timeLbl.text = "请选择比赛时间"
            chinaBtn.setImage(UIImage(named:"china1"), for: .normal)
        } else if ViewController.nation == "jp" {
            selectNationLbl.text = "言語を選択してください"
            timeLbl.text = "ゲームの時間を選択してください"
            japanBtn.setImage(UIImage(named:"japan1"), for: .normal)
        }
        
        if ViewController.second == "60s" {
            sixtyBtn.setImage(UIImage(named:"60s1"), for: .normal)
        } else {
            thirtyBtn.setImage(UIImage(named:"30s1"), for: .normal)
        }
        
    }
    
    @IBAction func backBtnTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func koreaBtnTap(_ sender: Any) {
        ViewController.nation = "kr"
        selectNationLbl.text = "언어를 선택해 주세요"
        timeLbl.text = "게임 시간을 선택해 주세요"
        koreaBtn.setImage(UIImage(named:"korea1"), for: .normal)
        usaBtn.setImage(UIImage(named:"usa0"), for: .normal)
        chinaBtn.setImage(UIImage(named:"china0"), for: .normal)
        japanBtn.setImage(UIImage(named:"japan0"), for: .normal)
    }
    
    @IBAction func usaBtnTap(_ sender: Any) {
        ViewController.nation = "us"
        selectNationLbl.text = "Please select a language"
        timeLbl.text = "Pleaes select a game time"
        koreaBtn.setImage(UIImage(named:"korea0"), for: .normal)
        usaBtn.setImage(UIImage(named:"usa1"), for: .normal)
        chinaBtn.setImage(UIImage(named:"china0"), for: .normal)
        japanBtn.setImage(UIImage(named:"japan0"), for: .normal)
    }
    
    @IBAction func chinaBtnTap(_ sender: Any) {
        ViewController.nation = "cn"
        selectNationLbl.text = "请选择一种语言"
        timeLbl.text = "请选择比赛时间"
        koreaBtn.setImage(UIImage(named:"korea0"), for: .normal)
        usaBtn.setImage(UIImage(named:"usa0"), for: .normal)
        chinaBtn.setImage(UIImage(named:"china1"), for: .normal)
        japanBtn.setImage(UIImage(named:"japan0"), for: .normal)
    }
    
    @IBAction func japanBtnTap(_ sender: Any) {
        ViewController.nation = "jp"
        selectNationLbl.text = "言語を選択してください"
        timeLbl.text = "ゲームの時間を選択してください"
        koreaBtn.setImage(UIImage(named:"korea0"), for: .normal)
        usaBtn.setImage(UIImage(named:"usa0"), for: .normal)
        chinaBtn.setImage(UIImage(named:"china0"), for: .normal)
        japanBtn.setImage(UIImage(named:"japan1"), for: .normal)
    }
    
    @IBAction func sixtyBtnTap(_ sender: Any) {
        ViewController.second = "60s"
        sixtyBtn.setImage(UIImage(named:"60s1"), for: .normal)
        thirtyBtn.setImage(UIImage(named:"30s0"), for: .normal)
    }
    
    @IBAction func thirtyBtnTap(_ sender: Any) {
        ViewController.second = "30s"
        sixtyBtn.setImage(UIImage(named:"60s0"), for: .normal)
        thirtyBtn.setImage(UIImage(named:"30s1"), for: .normal)
    }
    
    
}
