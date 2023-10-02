//
//  QuestionViewController.swift
//  Lab_Personality Quiz
//
//  Created by 曹家瑋 on 2023/10/2.
//

import UIKit

class QuestionViewController: UIViewController {

    // 顯示目前問題
    @IBOutlet weak var questionLabel: UILabel!
    
    // 單選問題的堆疊視圖，用於放置單選問題的選項Button
    @IBOutlet weak var singleStackView: UIStackView!
    @IBOutlet weak var singleButton1: UIButton!
    @IBOutlet weak var singleButton2: UIButton!
    @IBOutlet weak var singleButton3: UIButton!
    @IBOutlet weak var singleButton4: UIButton!
    
    // 多選問題的堆疊視圖，用於放置多選問題的選項Switch
    @IBOutlet weak var multipleStackView: UIStackView!
    @IBOutlet weak var multiLabel1: UILabel!
    @IBOutlet weak var multiLabel2: UILabel!
    @IBOutlet weak var multiLabel3: UILabel!
    @IBOutlet weak var multiLabel4: UILabel!
    // 多選題的Switch
    @IBOutlet weak var multiSwitch1: UISwitch!
    @IBOutlet weak var multiSwitch2: UISwitch!
    @IBOutlet weak var multiSwitch3: UISwitch!
    @IBOutlet weak var multiSwitch4: UISwitch!
    
    // 範圍型問題的堆疊視圖，用於放置表示範圍的Slider、Label
    @IBOutlet weak var rangeStackView: UIStackView!
    @IBOutlet weak var rangedLabel1: UILabel!
    @IBOutlet weak var rangedLabel2: UILabel!
    // Slider
    @IBOutlet weak var rangedSlider: UISlider!
    
    // 顯示答題進度的進度條
    @IBOutlet weak var questionProgressView: UIProgressView!
    
    // questions，它是 Question 物件的陣列，用於存儲所有的問題和答案
    var questions: [Question] = [
        // 第一個問題是單選題
        Question(text: "你最喜歡哪種食物？",
                 type: .single,
                 answers: [
                    Answer(text: "牛排", type: .dog),
                    Answer(text: "魚", type: .cat),
                    Answer(text: "胡蘿蔔", type: .rabbit),
                    Answer(text: "玉米", type: .turtle)
                 ]
                ),
        
        // 第二個問題是多選題
        Question(text: "你喜歡哪些活動？",
                 type: .multiple,
                 answers: [
                    Answer(text: "游泳", type: .turtle),
                    Answer(text: "睡覺", type: .cat),
                    Answer(text: "擁抱", type: .rabbit),
                    Answer(text: "吃東西", type: .dog)
                 ]
                ),
        
        // 第三個問題是範圍題
        Question(text: "你喜歡乘坐汽車嗎？",
                 type: .ranged,
                 answers: [
                    Answer(text: "我不喜歡", type: .cat),
                    Answer(text: "我會有點緊張", type: .rabbit),
                    Answer(text: "我幾乎沒注意到", type: .turtle),
                    Answer(text: "我很喜歡", type: .dog)
                 ]
                )
    ]
    
    /// 追蹤當前題目
    var questionIndex = 0
    /// 儲存玩家的答案
    var answersChosen: [Answer] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        updateUI()
    }
    
    // 當單選題按鈕被點擊時的動作
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        // 取得目前題目的答案集合
        let currentAnswers = questions[questionIndex].answers
        
        // 根據被點擊的按鈕來確定玩家選擇的答案
        switch sender {
        case singleButton1:
            answersChosen.append(currentAnswers[0])
        case singleButton2:
            answersChosen.append(currentAnswers[1])
        case singleButton3:
            answersChosen.append(currentAnswers[2])
        case singleButton4:
            answersChosen.append(currentAnswers[3])
        default:
            break
        }
        
        // 移至下一個問題
        nextQuestion()
    
    }
    
    // 當多選題按鈕被點擊時的動作
    @IBAction func multipleAnswerButtonPressed(_ sender: UIButton) {
        // 取得目前題目的答案集合
        let currentAnswers = questions[questionIndex].answers
        
        // 檢查每個開關，如果是打開的，則將相對應的答案添加到玩家選擇的答案集合中
        if multiSwitch1.isOn {
            answersChosen.append(currentAnswers[0])
        }
        if multiSwitch2.isOn {
            answersChosen.append(currentAnswers[1])
        }
        if multiSwitch3.isOn {
            answersChosen.append(currentAnswers[2])
        }
        if multiSwitch4.isOn {
            answersChosen.append(currentAnswers[3])
        }
        
        // 移至下一個問題
        nextQuestion()
    }

    // 當範圍答案按鈕被點擊時的動作
    @IBAction func rangedAnswerButtonPressed(_ sender: UIButton) {
        // 取得目前題目的答案集合
        let currentAnswers = questions[questionIndex].answers
        // 根據Slider的值，計算出玩家選擇的答案的索引
        let index = Int(round(rangedSlider.value * Float(currentAnswers.count - 1)))
        
        // 將玩家選擇的答案添加到答案集合中
        answersChosen.append(currentAnswers[index])
        
        // 移至下一個問題
        nextQuestion()
    }
    
    /// 前往下一個問題或顯示結果。
    func nextQuestion() {
        // 增加問題索引，以進行下一個問題。
        questionIndex += 1
        
        // 如果還有更多的問題，則更新界面。
        // 如果所有問題都已被回答，則執行結果的segue。
        if questionIndex < questions.count {
            updateUI()
        } else {
            performSegue(withIdentifier: "Results", sender: nil)
        }
    }
    
    /// 在執行Results segue時，使用此方法初始化並返回`ResultsViewController`。
    /// - Parameter coder: 一個對象，將用於初始化`ResultsViewController`。
    /// - Returns: 初始化的`ResultsViewController`或nil。
    @IBSegueAction func showResults(_ coder: NSCoder) -> ResultsViewController? {
        return ResultsViewController(coder: coder, response: answersChosen)
    }
    
    
    /// 主要目的是基於當前問題來更新用戶界面。
    func updateUI() {
        // 首先，將所有的堆疊視圖設置為隱藏狀態
        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangeStackView.isHidden = true
        
        // 獲取當前要顯示的問題
        let currentQuestion = questions[questionIndex]
        // 獲取對應的答案
        let currentAnswers = currentQuestion.answers
        // 計算問題的完成進度
        let totalProgress = Float(questionIndex) / Float(questions.count)
        
        // 設定Navigationbar的標題為當前問題的questionIndex
        navigationItem.title = "第 \(questionIndex + 1) 題"
        // 設置當前問題文字內容
        questionLabel.text = currentQuestion.text
        // 設置進度條的值
        questionProgressView.setProgress(totalProgress, animated: true)

        // 根據當前問題的類型來決定哪一個堆疊視圖應該顯示
        switch currentQuestion.type {
        case .single:
            updateSingleStack(using: currentAnswers)    // 單選
        case .multiple:
            updateMultipleStack(using: currentAnswers)  // 多選
        case .ranged:
            updateRangedStack(using: currentAnswers)    // 範圍選擇
        }
    }
    
    /// 根據提供的答案更新單選題的StackView。
    /// - Parameter answers: 與當前問題相關的答案列表。
    func updateSingleStack(using answers: [Answer]) {
        singleStackView.isHidden = false
        singleButton1.setTitle(answers[0].text, for: .normal)
        singleButton2.setTitle(answers[1].text, for: .normal)
        singleButton3.setTitle(answers[2].text, for: .normal)
        singleButton4.setTitle(answers[3].text, for: .normal)
    }
    
    /// 根據提供的答案更新多選題的StackView。
    /// - Parameter answers: 與當前問題相關的答案列表。
    func updateMultipleStack(using answers: [Answer]) {
        multipleStackView.isHidden = false
        // 將所有的開關重置為OFF。
        multiSwitch1.isOn = false
        multiSwitch2.isOn = false
        multiSwitch3.isOn = false
        multiSwitch4.isOn = false
        // 設置每個標籤的文字。
        multiLabel1.text = answers[0].text
        multiLabel2.text = answers[1].text
        multiLabel3.text = answers[2].text
        multiLabel4.text = answers[3].text
    }
    
    /// 根據提供的答案更新範圍題的StackView。
    /// - Parameter answers: 與當前問題相關的答案列表。
    func updateRangedStack(using answers: [Answer]) {
        rangeStackView.isHidden = false
        // 設置slider的值
        rangedSlider.setValue(0.5, animated: false)
        // 設置兩個label的文字
        rangedLabel1.text = answers.first?.text
        rangedLabel2.text = answers.last?.text
    }
}

