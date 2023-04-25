//
//  RankingLevelTrackLayer.swift
//  TestSlider
//
//  Created by son on 19/04/2023.
//

import QuartzCore
import UIKit

class RankingLevelTrackLayer: CALayer {
    
    let outterTrackColor = UIColor.white
    let innerTrackColor = UIColor.gray
    
    override func draw(in ctx: CGContext) {
        //outer track
        drawTrack(with: ctx, trackBounds: bounds, color: .white)
        
        let trackVerticalInset = 3.0
        
        //inner small track
        drawTrack(with: ctx, trackBounds: bounds.inset(by: UIEdgeInsets(top: trackVerticalInset, left: 0, bottom: trackVerticalInset, right: 0)), color: UIColor(hexString: "#D9D9D9"))
        
        //progress track
        drawTrack(with: ctx, trackBounds: bounds.inset(by: UIEdgeInsets(top: trackVerticalInset, left: 0, bottom: trackVerticalInset, right: 69)), color: UIColor(hexString: "#68A4D4"))
        
        shadowColor = UIColor(hexString: "#BABABA").cgColor
        shadowRadius = 2.0
        shadowOffset = CGSize(width: 1.0, height: 1.0)
        shadowOpacity = 0.6
    }
    
    private func drawTrack(with ctx: CGContext, trackBounds: CGRect, color: UIColor) {
        let cornerRadius = trackBounds.height * 0.5
        
        let path = UIBezierPath(roundedRect: trackBounds, cornerRadius: cornerRadius)
        
        ctx.setFillColor(color.cgColor)
        ctx.addPath(path.cgPath)

        
        ctx.fillPath()
    }
    
    
}
