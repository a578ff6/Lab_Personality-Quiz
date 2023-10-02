//
//  QuestionViewController.swift
//  Lab_Personality Quiz
//
//  Created by 曹家瑋 on 2023/10/2.
//

import UIKit

class QuestionViewController: UIViewController {

    @IBOutlet weak var singleStackView: UIStackView!
    
    @IBOutlet weak var multipleStackView: UIStackView!
    
    @IBOutlet weak var rangeStackView: UIStackView!
    
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    /// 主要目的是基於當前問題來更新用戶界面。
    func updateUI() {
        // 首先，將所有的堆疊視圖設置為隱藏狀態
        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangeStackView.isHidden = true
        
        // 設定Navigationbar的標題為當前問題的questionIndex
        navigationItem.title = "第 \(questionIndex + 1) 題"
        
        // 獲取當前要顯示的問題
        let currentQuestion = questions[questionIndex]
        
        // 根據當前問題的類型來決定哪一個堆疊視圖應該顯示
        switch currentQuestion.type {
        case .single:
            singleStackView.isHidden = false    // 如果是單選題，則顯示單選StackView
        case .multiple:
            multipleStackView.isHidden = false  // 如果是多選題，則顯示多選StackView
        case .ranged:
            rangeStackView.isHidden = false     // 如果是範圍題，則顯示範圍StackView
        }
    }

}

