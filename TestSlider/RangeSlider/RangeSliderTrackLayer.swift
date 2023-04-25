//
//  RangeSliderTrackLayer.swift
//  TestSlider
//
//  Created by son on 18/04/2023.
//

import QuartzCore
import UIKit

class RangeSliderTrackLayer: CALayer {
    weak var rangeSlider: RangeSlider?
    
    override func draw(in ctx: CGContext) {
        guard let slider = rangeSlider else {
            return
        }
        
        let cornerRadius = bounds.height * slider.curvaceousness / 2.0
        
        let path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        
        ctx.setFillColor(slider.trackTintColor.cgColor)
        ctx.addPath(path.cgPath)
        
        ctx.fillPath()
//
//        ctx.setFillColor(slider.trackHighlightTintColor.cgColor)
//
//        let lowerValuePosition = CGFloat(slider.positionForValue(value: slider.lowerValue))
//        let upperValuePosition = CGFloat(slider.positionForValue(value: slider.upperValue))
//
//        let rect = CGRect(x: lowerValuePosition, y: 0.0, width: upperValuePosition - lowerValuePosition, height: bounds.height)
//
//
//        ctx.fill(rect)
        
    }
}
