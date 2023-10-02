//
//  ResultsViewController.swift
//  Lab_Personality Quiz
//
//  Created by 曹家瑋 on 2023/10/2.
//

import UIKit

class ResultsViewController: UIViewController {
    /// 結果答案
    @IBOutlet weak var resultAnswerLabel: UILabel!
    /// 結果描述
    @IBOutlet weak var resultDefinitionLabel: UILabel!
    
    // 儲存使用者答案的屬性
    var responses: [Answer]
    
    // 使用特殊的初始化方法，以便當這個視圖控制器被實例化時能接收答案陣列
    init?(coder: NSCoder, response: [Answer]) {
        // 將傳入的答案設定給上面的屬性
        self.responses = response
        // 調用父類別的初始化方法
        super.init(coder: coder)
    }
    
    // 由於提供了自己的初始化方法，需要也實現這個預設的初始化方法
    // 但基本上用不到
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 計算結果
        calculatePersonalityResult()
        // 隱藏返回按鈕
        navigationItem.hidesBackButton = true
    }
    
    
    /// 計算並展示使用者的性格測試結果
    func calculatePersonalityResult() {
        // 將答案陣列轉化為字典，key 是答案的類型，value 是該類型答案的次數
        let frequencyOfAnswers = responses.reduce(into: [:]) {
            (counts, answer) in
            
                // 使用字典的下標取得當前答案類型的計數。
                // 如果答案類型在字典中不存在，則使用 default 參數設定預設值為 0。
                // 然後對該答案類型的計數進行累加
                counts[answer.type, default: 0] += 1
        }
        // 根據每種答案的出現次數，找到最常見的答案
        let mostCommonAnswer = frequencyOfAnswers.sorted { $0.1 > $1.1 }.first!.key
        
        // 將結果更新到介面上
        resultAnswerLabel.text = "你是一隻 \(mostCommonAnswer.rawValue)!"
        resultDefinitionLabel.text = mostCommonAnswer.definition
        
    }

}
