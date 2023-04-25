//
//  RankingLevelInfo.swift
//  TestSlider
//
//  Created by son on 19/04/2023.
//

import UIKit

struct RankingLevelInfo {
    let name: String
    let score: Int
    let tintColorCode: String
    let textColorCode: String
}

extension RankingLevelInfo {
    var tintColor: UIColor {
        return UIColor(hexString: tintColorCode)
    }
    
    var textColor: UIColor {
        return UIColor(hexString: textColorCode)
    }
}

struct RankingLevelViewData {
    let levelInfos: [RankingLevelInfo]
    let progress: Double
}

extension RankingLevelViewData {
    
    var currentRankIndex: Int {
        Int(progress / (1.0 / Double(levelInfos.count - 1)))
    }
    
    var progressColor: UIColor {
        if currentRankIndex < 0 {
            return .white
        }
        
        return levelInfos[currentRankIndex].tintColor
    }
}

extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1) {
        var cString: String = hexString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }
        
        if (cString.count) != 6 {
            self.init()
            return
        }
        
        var rgbValue: UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
}
