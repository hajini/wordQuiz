//
//  GameScreenVC.swift
//  wordQuiz
//
//  Created by Hajin Jeong on 2021/01/28.
//

import UIKit
import Speech

class GameScreenVC: UIViewController, SFSpeechRecognizerDelegate {

    @IBOutlet var timeLbl: UILabel!
    @IBOutlet var questionLbl: UILabel!
    @IBOutlet var questionImg: UIImageView!
    
    @IBOutlet var okayNumberLbl: UILabel!
    @IBOutlet var skipNumberLbl: UILabel!
    @IBOutlet var correctNo: UILabel!
    @IBOutlet var skipNo: UILabel!
    @IBOutlet var correctBtn: UIButton!
    @IBOutlet var passBtn: UIButton!
    
    @IBOutlet var statusLbl: UILabel!
    
    @IBOutlet var stopGameBtn: UIButton!
    
    @IBOutlet var microphoneButton: UIButton!
    
    var correct0 = 0
    var skip0 = 0
    var recordedHistory = ""
    
    var recordedWords = [String]()
    
    var timer = Timer()
    deinit {
        timer.invalidate()
    }
    var startTime: Date?
    
    private var speechRecognizer = SFSpeechRecognizer()
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    
    
    var koreanWords = ViewController.koreanWordsAdult
    var engWords = ViewController.engWordsAdult
    var chinaWords = ViewController.chinaWordsAdult
    var japanWords = ViewController.japanWordsAdult
    
    var voiceLanguageCorrect = ""
    var voiceLanguagePass = ""
    var languageCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timeLbl.font = UIFont(name: "GodoM", size: 40)!
        questionLbl.font = UIFont(name: "GodoM", size: 100)!
        okayNumberLbl.font = UIFont(name: "GodoM", size: 20)!
        skipNumberLbl.font = UIFont(name: "GodoM", size: 20)!
        correctNo.font = UIFont(name: "GodoM", size: 20)!
        skipNo.font = UIFont(name: "GodoM", size: 20)!
        correctBtn.titleLabel!.font = UIFont(name: "GodoB", size: 25)!
        passBtn.titleLabel!.font = UIFont(name: "GodoB", size: 25)!
        
        typeSelector()
        
        setTimer(startTime: Date())
        
        microphoneButton.isHidden = true
        microphoneButton.isEnabled = false
        
        if ViewController.nation == "kr" {
            speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "ko-KR"))!
            correctBtn.setTitle("정답", for: .normal)
            passBtn.setTitle("패스", for: .normal)
            voiceLanguageCorrect = "정답"
            voiceLanguagePass = "패스"
            languageCount = 3
        } else if ViewController.nation == "us" {
            speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "en-US"))!
            voiceLanguageCorrect = "correct"
            voiceLanguagePass = "pass"
            correctBtn.setTitle("correct", for: .normal)
            passBtn.setTitle("pass", for: .normal)
            languageCount = 7
        } else if ViewController.nation == "cn" {
            speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "zh-CN"))!
            voiceLanguageCorrect = "回答"
            voiceLanguagePass="经过"
            correctBtn.setTitle("回答", for: .normal)
            passBtn.setTitle("经过", for: .normal)
            languageCount = 3
        } else if ViewController.nation == "jp" {
            speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "ja-JP"))!
            voiceLanguageCorrect = "正解"
            voiceLanguagePass="パス"
            correctBtn.setTitle("正解", for: .normal)
            passBtn.setTitle("パス", for: .normal)
            languageCount = 3
        }
        
        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            var isButtonEnabled = false
            switch authStatus {
            case .authorized:
                isButtonEnabled = true

            case .denied:
                isButtonEnabled = false
                print("User denied access to speech recognition")

            case .restricted:
                isButtonEnabled = false
                print("Speech recognition restricted on this device")

            case .notDetermined:
                isButtonEnabled = false
                print("Speech recognition not yet authorized")
            @unknown default:
                fatalError()
            }

            OperationQueue.main.addOperation() {
                self.microphoneButton.isEnabled = isButtonEnabled
                self.microphoneTapped(self.microphoneButton)
            }
        }
        
        
    }
    
    @IBAction func microphoneTapped(_ sender: AnyObject) {
           if audioEngine.isRunning {
               audioEngine.stop()
               recognitionRequest?.endAudio()
               microphoneButton.isEnabled = false
               microphoneButton.setTitle("Start Recording", for: .normal)
           } else {
               startRecording()
               microphoneButton.setTitle("Stop Recording", for: .normal)
           }
    }
    
    
    @IBAction func stopGameBtnTap(_ sender: Any) {
        
        let alert = UIAlertController(title: "게임 중단", message: "게임을 중단하고 첫 화면으로 돌아갑니다", preferredStyle: .alert)
        let alertBack = UIAlertAction(title: "게임 중단", style: .destructive) { (UIAlertAction) in
            self.view.window?.rootViewController?.dismiss(animated: false, completion: {
            })
        }
        let alertCancel = UIAlertAction(title: "게임 계속하기", style: .cancel) { (UIAlertAction) in
            //
        }
        alert.addAction(alertCancel)
        alert.addAction(alertBack)
        present(alert, animated: true, completion: nil)
        
        
    }
    @IBAction func skipBtnTap(_ sender: Any) {
        skip()
    }
    
    @IBAction func okayBtnTap(_ sender: Any) {
        answer()
    }
    
    private func setTimer(startTime: Date) {
            DispatchQueue.main.async { [weak self] in
                self?.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
                    let elapsedTimeSeconds = Int(Date().timeIntervalSince(startTime))
                    var expireLimit = 60
                    if ViewController.second == "60s" {
                        expireLimit = 60
                    } else {
                        expireLimit = 30
                    }
                    

                    guard elapsedTimeSeconds <= expireLimit else { // 시간 초과한 경우
                        timer.invalidate()
                        
                        self!.moveToNext()
                        return
                    }

                    let remainSeconds = expireLimit - elapsedTimeSeconds
                    self?.timeLbl.text = String(describing: remainSeconds.self)
                    
                    
                    
                }
            }
        }
    
    func answer() {
        correct0 = correct0 + 1
        correctNo.text = "\(correct0)"
         
        if ViewController.old == "child" {
            //어린이용 그림
            questionLbl.isHidden = true
            questionImg.isHidden = false
            
        } else {
            //어른용 단어
            questionLbl.isHidden = false
            questionImg.isHidden = true
            if ViewController.nation == "kr" {
                let word01 = koreanWords.randomElement()
                questionLbl.text = word01
                koreanWords.removeAll(where: { $0 == "\(String(describing: word01))" })
            } else if ViewController.nation == "us" {
                let word02 = engWords.randomElement()
                questionLbl.text = word02
                engWords.removeAll(where: { $0 == "\(String(describing: word02))" })
            } else if ViewController.nation == "cn" {
                let word03 = chinaWords.randomElement()
                questionLbl.text = word03
                chinaWords.removeAll(where: { $0 == "\(String(describing: word03))" })
            } else if ViewController.nation == "jp" {
                let word04 = japanWords.randomElement()
                questionLbl.text = word04
                japanWords.removeAll(where: { $0 == "\(String(describing: word04))" })
            }
            
        }
            
            
    }
    
    func skip() {
        skip0 = skip0 + 1
        skipNo.text = "\(skip0)"
        
        if ViewController.old == "child" {
            //어린이용 그림
            questionLbl.isHidden = true
            questionImg.isHidden = false
            
        } else {
            //어른용 단어
            questionLbl.isHidden = false
            questionImg.isHidden = true
            if ViewController.nation == "kr" {
                let word01 = koreanWords.randomElement()
                questionLbl.text = word01
                koreanWords.removeAll(where: { $0 == "\(String(describing: word01))" })
            } else if ViewController.nation == "us" {
                let word02 = engWords.randomElement()
                questionLbl.text = word02
                engWords.removeAll(where: { $0 == "\(String(describing: word02))" })
            } else if ViewController.nation == "cn" {
                let word03 = chinaWords.randomElement()
                questionLbl.text = word03
                chinaWords.removeAll(where: { $0 == "\(String(describing: word03))" })
            } else if ViewController.nation == "jp" {
                let word04 = japanWords.randomElement()
                questionLbl.text = word04
                japanWords.removeAll(where: { $0 == "\(String(describing: word04))" })
            }
            
        }
            
    }
    
    func moveToNext() {
        ScoreVC.finalScore = correct0
        ScoreVC.finalSkip = skip0
        let profilesb = UIStoryboard(name: "Main", bundle: nil)
        let VC = profilesb.instantiateViewController(withIdentifier: "score")
        VC.modalPresentationStyle = .fullScreen
        present(VC, animated: true, completion: nil)
        
    }
    
   
}

extension GameScreenVC {
    // 단어 혹은 그림
    func typeSelector() {
        if ViewController.old == "child" {
            //어린이용 그림
            
            questionLbl.isHidden = true
            questionImg.isHidden = false
        } else {
            
            //어른용 단어
            questionLbl.isHidden = false
            questionImg.isHidden = true
            if ViewController.nation == "kr" {
                let word01 = koreanWords.randomElement()
                questionLbl.text = word01
                koreanWords.removeAll(where: { $0 == "\(String(describing: word01))" })
            } else if ViewController.nation == "us" {
                let word02 = engWords.randomElement()
                questionLbl.text = word02
                engWords.removeAll(where: { $0 == "\(String(describing: word02))" })
            } else if ViewController.nation == "cn" {
                let word03 = chinaWords.randomElement()
                questionLbl.text = word03
                chinaWords.removeAll(where: { $0 == "\(String(describing: word03))" })
            } else if ViewController.nation == "jp" {
                let word04 = japanWords.randomElement()
                questionLbl.text = word04
                japanWords.removeAll(where: { $0 == "\(String(describing: word04))" })
            }
        }
            
    }
    
}

extension GameScreenVC {
    //음성인식
    func startRecording() {

        if recognitionTask != nil {  //1
            recognitionTask?.cancel()
            recognitionTask = nil
        }

        let audioSession = AVAudioSession.sharedInstance()  //2
        do {
            try audioSession.setCategory(AVAudioSession.Category.record)
            try audioSession.setMode(AVAudioSession.Mode.measurement)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("audioSession properties weren't set because of an error.")
        }

        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()  //3

        let inputNode = audioEngine.inputNode

        guard let recognitionRequest = recognitionRequest else {
            fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
        } //5

        recognitionRequest.shouldReportPartialResults = true  //6

        recognitionTask = speechRecognizer!.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in  //7

            var isFinal = false  //8

            if result != nil {

//                self.statusLbl.text = result?.bestTranscription.formattedString  //9
                self.recordedWords.append((result?.bestTranscription.formattedString)!)
                
                let a = self.recordedWords.last!
                
                if self.recordedHistory != a {
                    self.recordedHistory = a
                    if a.count <= self.languageCount {
                        print(a)
                        
                        if a.contains("\(self.voiceLanguageCorrect)") {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                                self.answer()
                            })
                        } else if a.contains("\(self.voiceLanguagePass)") {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                                self.skip()
                            })
                        }
                    }
                    
                    if a.count > self.languageCount {
                        
                        let b = a.index(a.endIndex, offsetBy: -self.languageCount)..<a.endIndex
                        print(a[b])
                        
                        if a[b].contains("\(self.voiceLanguageCorrect)") {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                                self.answer()
                            })
                        } else if a[b].contains("\(self.voiceLanguagePass)") {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                                self.skip()
                            })
                        }
                    }
                }
                
                isFinal = (result?.isFinal)!
                
            }

            if error != nil || isFinal {  //10
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)

                self.recognitionRequest = nil
                self.recognitionTask = nil

                self.microphoneButton.isEnabled = true
            }
        })

        let recordingFormat = inputNode.outputFormat(forBus: 0)  //11
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            self.recognitionRequest?.append(buffer)
        }

        audioEngine.prepare()  //12

        do {
            try audioEngine.start()
        } catch {
            print("audioEngine couldn't start because of an error.")
        }

        statusLbl.text = "음성 기능 정상 작동중"

    }

    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if available {
            microphoneButton.isEnabled = true
        } else {
            microphoneButton.isEnabled = false
        }
    }

}
