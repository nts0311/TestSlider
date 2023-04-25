//
//  ViewController.swift
//  TestSlider
//
//  Created by son on 17/04/2023.
//

import UIKit

class ViewController: UIViewController {
    
    let rangeSlider = RankingLevelView(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(rangeSlider)
        view.backgroundColor = UIColor(hexString: "#FAFAFA")
    }

    override func viewDidLayoutSubviews() {
        
        let data = RankingLevelViewData(levelInfos: [
            RankingLevelInfo(name: "", score: 0, tintColorCode: "#68A4D4", textColorCode: "#9F5608"),
            RankingLevelInfo(name: "Bronze", score: 100, tintColorCode: "#C86B24", textColorCode: "#9F5608"),
            RankingLevelInfo(name: "Silver", score: 500, tintColorCode: "#8D98BE", textColorCode: "#8F939C"),
            RankingLevelInfo(name: "Gold", score: 1000, tintColorCode: "#F59B13", textColorCode: "#C88F05"),
            RankingLevelInfo(name: "Diamond", score: 3000, tintColorCode: "#9420F4", textColorCode: "#536AAD"),
            RankingLevelInfo(name: "Platinum", score: 5000, tintColorCode: "#A90559", textColorCode: "#1F6B92")
            
        ], progress: 0.74)
        
        let margin: CGFloat = 24.0
        let width = view.bounds.width - 2.0 * margin
        rangeSlider.frame = CGRect(x: margin, y: margin + view.safeAreaInsets.top ,
                                   width: width, height: 169.0)
        rangeSlider.data = data
        //rangeSlider.layer.borderColor = UIColor.black.cgColor
        //rangeSlider.layer.borderWidth = 1

    }
}

