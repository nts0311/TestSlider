//
//  RankingLevelNodeLayer.swift
//  TestSlider
//
//  Created by son on 24/04/2023.
//

import QuartzCore
import UIKit

struct LevelNode {
    let color: UIColor
    let size: CGFloat
    let isHighlightNode: Bool = false
}

class RankingLevelNodeLayer: CALayer {
    var nodes: [LevelNode] = [] {
        didSet {
            //setNeedsLayout()
        }
    }
    
    var nodeSize: CGFloat {
        nodes.first?.size ?? 0.0
    }
    
    var nodeRadius: CGFloat {
        nodeSize / 2.0
    }
    
    var drawShadows: Bool = true
    
    override func draw(in ctx: CGContext) {
        guard !nodes.isEmpty else { return }
        
        let centerY = bounds.height / 2.0
        
        var x = nodeRadius
        let distanceBetweenNode = (bounds.width - nodeRadius * 2.0) / CGFloat(nodes.count - 1)
        
        for i in nodes.indices {
            draw(node: nodes[i], center: CGPoint(x: x, y: centerY), in: ctx)
            x += distanceBetweenNode
        }
        
        if drawShadows {
            makeShadows()
        }
        
    }
    
    private func makeShadows() {
        shadowColor = UIColor(hexString: "#BABABA").cgColor
        shadowRadius = 6.0
        shadowOffset = CGSize(width: 1.0, height: 1.0)
        shadowOpacity = 0.8
    }
    
    private func draw(node: LevelNode, center: CGPoint, in ctx: CGContext) {
        let radius = node.size / 2.0
        let circlePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
        
        ctx.setFillColor(node.color.cgColor)
        ctx.addPath(circlePath.cgPath)
        ctx.fillPath()
    }
    
}
