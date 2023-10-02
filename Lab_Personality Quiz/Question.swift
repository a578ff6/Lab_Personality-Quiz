//
//  Question.swift
//  Lab_Personality Quiz
//
//  Created by 曹家瑋 on 2023/10/2.
//

import Foundation

// MARK: - Question and Response

/// 問題的struct：每個問題都有文字描述、問題類型（單選、多選、範圍）和答案選項。
struct Question {
    var text: String            // 問題文字
    var type: ResponseType      // 問題類型
    var answers: [Answer]       // 可選答案列表
}

/// 問題類型
enum ResponseType {
    case single
    case multiple
    case ranged
}


// MARK: - Answer and Animal Types

/// 答案的結構：每個答案都會對應到一種動物結果。
struct Answer {
    var text: String        // 答案的文字描述
    var type: AnimalType    // 對應的動物結果
}

/// 動物結果的詳細描述：在測驗結束時，玩家會看到他們的動物結果，以及與該動物相關的性格描述。
enum AnimalType: Character {
    case dog = "🐶"
    case cat = "🐱"
    case rabbit = "🐰"
    case turtle = "🐢"
    
    var definition: String {
        switch self {
        case .dog:
            return "你非常外向。你喜歡和你愛的人在一起，並且享受和朋友的活動。"
        case .cat:
            return "你淘氣但脾氣溫和，你喜歡按照自己的方式做事。"
        case .rabbit:
            return "你喜歡所有柔軟的東西。你很健康，充滿活力。"
        case .turtle:
            return "你比實際年齡更有智慧，並且專注於細節。穩健而有耐心的你總能取得最後的勝利。"
        }
    }
}
 
