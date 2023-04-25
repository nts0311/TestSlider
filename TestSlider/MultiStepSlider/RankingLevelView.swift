//
//  RankingLevelView.swift
//  TestSlider
//
//  Created by son on 19/04/2023.
//

import QuartzCore
import UIKit

class RankingLevelView: UIControl {
    let trackLayer = RankingLevelTrackLayer()
    let backNodeLayer = RankingLevelNodeLayer()
    let fontNodeLayer = RankingLevelNodeLayer()
    let hightlightLayer = CAShapeLayer()
    let topTextLayer = RankingLevelTextLayer()
    let bottomTextLayer = RankingLevelTextLayer()
    
    let outterNodeLayerHeight = 24.0
    let fontNodeLayerHeight = 18.0
    let trackLayerHeight = 12.0
    
    var levelInfos: [RankingLevelInfo] = []
    
    var highlightRadius: CGFloat {
        fontNodeLayerHeight / 2.0 + 10.0
    }
    
    var data: RankingLevelViewData = RankingLevelViewData(levelInfos: [], progress: 0) {
        didSet {
            updateLayerFrames()
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       
        layer.addSublayer(backNodeLayer)
        layer.addSublayer(trackLayer)
        layer.addSublayer(hightlightLayer)
        layer.addSublayer(fontNodeLayer)
        layer.addSublayer(topTextLayer)
        layer.addSublayer(bottomTextLayer)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func updateLayerFrames() {
        updateFrameBackNodeLayer()
        updateFrameFrontNodeLayer()
        updateFrameTrackLayer()
        highlightNode()
        updateFrameOfTopTextLayer()
        updateFrameOfBottomTextLayer()
    }
    
    private func updateFrameBackNodeLayer() {
        backNodeLayer.frame = CGRect(x: 0, y: (self.bounds.height / 2.0) - (outterNodeLayerHeight / 2.0), width: self.bounds.width, height: outterNodeLayerHeight)
        backNodeLayer.nodes = Array(repeating: LevelNode(color: .white, size: outterNodeLayerHeight), count: data.levelInfos.count)
        backNodeLayer.setNeedsDisplay()
    }
    
    private func updateFrameTrackLayer() {
        let trackLayerX = outterNodeLayerHeight / 2.0
        let trackLayerFrame = CGRect(x: trackLayerX, y: (self.bounds.height / 2.0) - (trackLayerHeight / 2.0), width: self.bounds.width - 2 * trackLayerX, height: trackLayerHeight)
        trackLayer.frame = trackLayerFrame
        trackLayer.progress = data.progress
        trackLayer.progressColor = data.progressColor
        
        trackLayer.setNeedsDisplay()
    }
    
    private func updateFrameFrontNodeLayer() {
        let nodeLayerWidthDelta = (outterNodeLayerHeight - fontNodeLayerHeight) / 2.0
        fontNodeLayer.frame = CGRect(x: nodeLayerWidthDelta, y: (self.bounds.height / 2.0) - (fontNodeLayerHeight / 2.0), width: self.bounds.width - nodeLayerWidthDelta * 2, height: fontNodeLayerHeight)
        
        fontNodeLayer.nodes = []
        
        for i in data.levelInfos.indices {
            let color = (i <= data.currentRankIndex) ? data.progressColor : UIColor(hexString: "#D9D9D9")
            fontNodeLayer.nodes.append(LevelNode(color: color, size: fontNodeLayerHeight))
        }
        
        fontNodeLayer.drawShadows = false
        fontNodeLayer.setNeedsDisplay()
    }
    
    private func updateFrameOfTopTextLayer() {
        let layerHeight = 20.0
        let y: CGFloat = bounds.height / 2.0 - highlightRadius - layerHeight - 8.0
        topTextLayer.frame = CGRect(x: 0, y: y, width: bounds.width, height: layerHeight)
        
        topTextLayer.texts = data.levelInfos.map { $0.name }
        topTextLayer.colors = data.levelInfos.map { $0.textColor }
        topTextLayer.setNeedsDisplay()
    }
    
    private func updateFrameOfBottomTextLayer() {
        let layerHeight = 20.0
        let y: CGFloat = bounds.height / 2.0 + highlightRadius / 2.0 + 4.0
        bottomTextLayer.frame = CGRect(x: 0, y: y, width: bounds.width, height: layerHeight)
        
        bottomTextLayer.texts = data.levelInfos.map { "\($0.score)" }
        bottomTextLayer.colors = data.levelInfos.map { $0.textColor }
        bottomTextLayer.setNeedsDisplay()
    }
    
    private func highlightNode() {
        let centerY = bounds.height / 2.0
        
        let distanceBetweenNode = (bounds.width - outterNodeLayerHeight) / CGFloat(data.levelInfos.count - 1)
        let x = Double(data.currentRankIndex) * distanceBetweenNode + highlightRadius / 2.0
        
        let color = data.progressColor
        
        hightlightLayer.shadowColor = color.cgColor
        
        hightlightLayer.shadowPath = UIBezierPath(arcCenter: CGPoint(x: x, y: centerY), radius: highlightRadius, startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true).cgPath
        
        hightlightLayer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        
        hightlightLayer.shadowOpacity = 0.4
        
        hightlightLayer.setNeedsDisplay()
        
        hightlightLayer.borderColor = UIColor.blue.cgColor
        hightlightLayer.borderWidth = 1.0
    }
}
