//
//  ViewController.swift
//  wordQuiz
//
//  Created by Hajin Jeong on 2021/01/26.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var selectBtn01: UIButton!
    @IBOutlet var selectBtn05: UIButton!
    
    static var nation = "kr"
    static var second = "60s"
    static var old = ""
    
    static var koreanWordsAdult = [String]()
    static var koreanWordsChild = [String]()
    static var engWordsAdult = [String]()
    static var engWordsChild = [String]()
    static var chinaWordsAdult = [String]()
    static var chinaWordsChild = [String]()
    static var japanWordsAdult = [String]()
    static var japanWordsChild = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        titleLbl.text = ""
        titleLbl.font = UIFont(name: "GodoM", size: 40)!
        
        selectBtn01.setTitle("", for: .normal)
        selectBtn01.titleLabel!.font = UIFont(name: "GodoM", size: 20)!
        selectBtn05.setTitle("", for: .normal)
        selectBtn05.titleLabel!.font = UIFont(name: "GodoM", size: 20)!
        
        readTxt()
    }

    override func viewDidAppear(_ animated: Bool) {
        
        if ViewController.nation == "kr" {
            titleLbl.text = "플레이어의 연령대를 선택해 주세요."
            selectBtn01.setTitle("어린이", for: .normal)
            selectBtn05.setTitle("성인", for: .normal)
        } else if ViewController.nation == "us" {
            titleLbl.text = "Please select the player's age range."
            selectBtn01.setTitle("Child", for: .normal)
            selectBtn05.setTitle("Adult", for: .normal)
        } else if ViewController.nation == "cn" {
            titleLbl.text = "请选择玩家的年龄范围."
            selectBtn01.setTitle("孩子", for: .normal)
            selectBtn05.setTitle("成人", for: .normal)
        } else if ViewController.nation == "jp" {
            titleLbl.text = "プレイヤーの年齢を選択してください."
            selectBtn01.setTitle("子供", for: .normal)
            selectBtn05.setTitle("成人", for: .normal)
        }
        
    }
    
    
    @IBAction func selectBtnTap01(_ sender: Any) {
        ViewController.old = "child"
        moveToNext()
        
    }
    @IBAction func selectBtnTap05(_ sender: Any) {
        ViewController.old = "adult"
        moveToNext()
    }
    @IBAction func settingBtnTap(_ sender: Any) {
        let profilesb = UIStoryboard(name: "Main", bundle: nil)
        let VC = profilesb.instantiateViewController(withIdentifier: "setting")
        VC.modalPresentationStyle = .fullScreen
        present(VC, animated: true, completion: nil)
    }
    
    func moveToNext() {
        let profilesb = UIStoryboard(name: "Main", bundle: nil)
        let VC = profilesb.instantiateViewController(withIdentifier: "gameManual")
        VC.modalPresentationStyle = .fullScreen
        present(VC, animated: true, completion: nil)
    }
    
    
    func readTxt() {
        if let filepath = Bundle.main.path(forResource: "koreanWordsAdult", ofType: "txt") {
            do {
                let data = try String(contentsOfFile: filepath, encoding: String.Encoding.utf8)
                ViewController.koreanWordsAdult = data.components(separatedBy: "\n")

//                print(ViewController.koreanWordsAdult)
            } catch {
                
            }
        } else {
            
        }
        
        if let filepath = Bundle.main.path(forResource: "engWordsAdult", ofType: "txt") {
            do {
                let data = try String(contentsOfFile: filepath, encoding: String.Encoding.utf8)
                let engWords = data.components(separatedBy: "\r")
                for a in engWords {
                    if a.contains("\n") {
                        let b = a.components(separatedBy: "\n").joined()
                        ViewController.engWordsAdult.append(b)
                    } else {
                        ViewController.engWordsAdult.append(a)
                    }
                }
//                print(ViewController.engWordsAdult)
            } catch {
                
            }
        } else {
            
        }
        
        if let filepath = Bundle.main.path(forResource: "chinaWordsAdult", ofType: "txt") {
            do {
                let data = try String(contentsOfFile: filepath, encoding: String.Encoding.utf8)
                let engWords = data.components(separatedBy: "\r")
                for a in engWords {
                    if a.contains("\n") {
                        let b = a.components(separatedBy: "\n").joined()
                        ViewController.chinaWordsAdult.append(b)
                    } else {
                        ViewController.chinaWordsAdult.append(a)
                    }
                }
//                print(ViewController.chinaWordsAdult)
            } catch {
                
            }
        } else {
            
        }
        
        if let filepath = Bundle.main.path(forResource: "japanWordsAdult", ofType: "txt") {
            do {
                let data = try String(contentsOfFile: filepath, encoding: String.Encoding.utf8)
                let engWords = data.components(separatedBy: "\r")
                for a in engWords {
                    if a.contains("\n") {
                        let b = a.components(separatedBy: "\n").joined()
                        ViewController.japanWordsAdult.append(b)
                    } else {
                        ViewController.japanWordsAdult.append(a)
                    }
                }
//                print(ViewController.japanWordsAdult)
            } catch {
                
            }
        } else {
            
        }
    }
}

