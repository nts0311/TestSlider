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
        let margin: CGFloat = 24.0
        let width = view.bounds.width - 2.0 * margin
        rangeSlider.frame = CGRect(x: margin, y: margin + view.safeAreaInsets.top ,
                                   width: width, height: 169.0)
        //rangeSlider.layer.borderColor = UIColor.black.cgColor
        //rangeSlider.layer.borderWidth = 1

    }
}

