//
//  RangeSlider.swift
//  TestSlider
//
//  Created by son on 17/04/2023.
//

import UIKit
import QuartzCore

class RangeSlider: UIControl {
    
    var minimumValue = 0.0
    var maximumValue = 1.0
    var lowerValue = 0.2
    var upperValue = 0.8

    let trackLayer = RangeSliderTrackLayer()
    let lowerThumbLayer = RangeSliderThumbLayer()
    let upperThumbLayer = RangeSliderThumbLayer()
    
    var previousLocation = CGPoint()
    
    var trackTintColor = UIColor(white: 0.9, alpha: 1.0)
    var trackHighlightTintColor = UIColor(red: 0.0, green: 0.45, blue: 0.94, alpha: 1.0)
    var thumbTintColor = UIColor.white

    var curvaceousness : CGFloat = 1.0
    
    var thumbWidth: CGFloat {
        return CGFloat(bounds.height)
    }
    
    override var frame: CGRect {
        didSet {
            updateLayerFrames()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        lowerThumbLayer.parent = self
        upperThumbLayer.parent = self
        trackLayer.rangeSlider = self
        
        //trackLayer.backgroundColor = UIColor.blue.cgColor
        trackLayer.contentsScale = UIScreen.main.scale
        layer.addSublayer(trackLayer)
        
        //lowerThumbLayer.backgroundColor = UIColor.green .cgColor
        lowerThumbLayer.contentsScale = UIScreen.main.scale
        layer.addSublayer(lowerThumbLayer)
        
        //upperThumbLayer.backgroundColor = UIColor.green .cgColor
        upperThumbLayer.contentsScale = UIScreen.main.scale
        layer.addSublayer(upperThumbLayer)
        
        updateLayerFrames()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        previousLocation = touch.location(in: self)
        
        if lowerThumbLayer.frame.contains(previousLocation) {
            lowerThumbLayer.highlighted = true
        } else if upperThumbLayer.frame.contains(previousLocation) {
            upperThumbLayer.highlighted = true
        }
        
        return lowerThumbLayer.highlighted || upperThumbLayer.highlighted
    }
    
    func boundValue(value: Double, toLowerValue lowerValue: Double, upperValue: Double) -> Double {
        return min(max(value, lowerValue), upperValue)
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let location = touch.location(in: self)
        
        let deltaLocation = location.x - previousLocation.x
        let deltaValue = (maximumValue - minimumValue) * deltaLocation / (bounds.width - thumbWidth)
        
        previousLocation = location
        
        if lowerThumbLayer.highlighted {
            lowerValue += deltaValue
            lowerValue = boundValue(value: lowerValue, toLowerValue: minimumValue, upperValue: upperValue)
        } else if upperThumbLayer.highlighted {
            upperValue += deltaValue
            upperValue = boundValue(value: upperValue, toLowerValue: lowerValue, upperValue: maximumValue)
        }
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        updateLayerFrames()
        
        CATransaction.commit()
        sendActions(for: .valueChanged)
        
        return true
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        lowerThumbLayer.highlighted = false
        upperThumbLayer.highlighted = false
    }
    
    func updateLayerFrames() {
        trackLayer.frame = bounds.insetBy(dx: 0.0, dy: bounds.height / 3)
        trackLayer.setNeedsDisplay()
        
        let lowerThumbCenter = positionForValue(value: lowerValue)
        lowerThumbLayer.frame = CGRect(x: CGFloat(lowerThumbCenter - thumbWidth / 2.0), y: 0.0, width: thumbWidth, height: thumbWidth)
        lowerThumbLayer.setNeedsDisplay()
        
        let upperThumbCenter = positionForValue(value: upperValue)
        upperThumbLayer.frame = CGRect(x: CGFloat(upperThumbCenter - thumbWidth / 2.0), y: 0.0, width: thumbWidth, height: thumbWidth)
        upperThumbLayer.setNeedsDisplay()
    }
    
    func positionForValue(value: Double) -> Double {
        return Double(bounds.width - thumbWidth) * (value - minimumValue) /
            (maximumValue - minimumValue) + Double(thumbWidth / 2.0)
    }
}
