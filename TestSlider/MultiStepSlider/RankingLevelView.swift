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
    
    override var frame: CGRect {
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
        backNodeLayer.frame = CGRect(x: 0, y: (self.bounds.height / 2.0) - (outterNodeLayerHeight / 2.0), width: self.bounds.width, height: outterNodeLayerHeight)
        backNodeLayer.nodes = [
            LevelNode(color: .white, size: outterNodeLayerHeight),
            LevelNode(color: .white, size: outterNodeLayerHeight),
            LevelNode(color: .white, size: outterNodeLayerHeight),
            LevelNode(color: .white, size: outterNodeLayerHeight),
            LevelNode(color: .white, size: outterNodeLayerHeight),
            LevelNode(color: .white, size: outterNodeLayerHeight)
        ]
        
        backNodeLayer.setNeedsDisplay()
        
        
        let nodeLayerWidthDelta = (outterNodeLayerHeight - fontNodeLayerHeight) / 2.0
        fontNodeLayer.frame = CGRect(x: nodeLayerWidthDelta, y: (self.bounds.height / 2.0) - (fontNodeLayerHeight / 2.0), width: self.bounds.width - nodeLayerWidthDelta * 2, height: fontNodeLayerHeight)
        let progressColor = UIColor(hexString: "#68A4D4")
        fontNodeLayer.nodes = [
            LevelNode(color: progressColor, size: fontNodeLayerHeight),
            LevelNode(color: progressColor, size: fontNodeLayerHeight),
            LevelNode(color: progressColor, size: fontNodeLayerHeight),
            LevelNode(color: progressColor, size: fontNodeLayerHeight),
            LevelNode(color: progressColor, size: fontNodeLayerHeight),
            LevelNode(color: .gray, size: fontNodeLayerHeight)
        ]
        fontNodeLayer.drawShadows = false
        fontNodeLayer.setNeedsDisplay()
        
        
        
        let trackLayerX = outterNodeLayerHeight / 2.0
        let trackLayerFrame = CGRect(x: trackLayerX, y: (self.bounds.height / 2.0) - (trackLayerHeight / 2.0), width: self.bounds.width - 2 * trackLayerX, height: trackLayerHeight)
        trackLayer.frame = trackLayerFrame
        trackLayer.setNeedsDisplay()
        
        highlightNode()
        
        updateFrameOfTopTextLayer()
        updateFrameOfBottomTextLayer()
    }
    
    private func updateFrameOfTopTextLayer() {
        let layerHeight = 20.0
        let y: CGFloat = bounds.height / 2.0 - highlightRadius - layerHeight - 8.0
        topTextLayer.frame = CGRect(x: 0, y: y, width: bounds.width, height: layerHeight)
        topTextLayer.texts = ["", "Bronze","Silver","Gold","Diamond","Platinum"]
        //topTextLayer.texts = ["", "Đồng","Bạc","Vàng","Kim cương","Bạch kim"]
        topTextLayer.colors = [
            UIColor(hexString: "#9F5608"),
            UIColor(hexString: "#9F5608"),
            UIColor(hexString: "#8F939C"),
            UIColor(hexString: "#C88F05"),
            UIColor(hexString: "#536AAD"),
            UIColor(hexString: "#1F6B92")
        ]
        //topTextLayer.borderColor = UIColor.blue.cgColor
        //topTextLayer.borderWidth = 1
        topTextLayer.setNeedsDisplay()
    }
    
    private func updateFrameOfBottomTextLayer() {
        let layerHeight = 20.0
        let y: CGFloat = bounds.height / 2.0 + highlightRadius / 2.0
        bottomTextLayer.frame = CGRect(x: 0, y: y, width: bounds.width, height: layerHeight)
        
        bottomTextLayer.texts = ["0", "100","500","1000","3000","5000"]
        bottomTextLayer.colors = [
            UIColor(hexString: "#9F5608"),
            UIColor(hexString: "#9F5608"),
            UIColor(hexString: "#8F939C"),
            UIColor(hexString: "#C88F05"),
            UIColor(hexString: "#536AAD"),
            UIColor(hexString: "#1F6B92")
        ]
        //topTextLayer.borderColor = UIColor.blue.cgColor
        //topTextLayer.borderWidth = 1
        bottomTextLayer.setNeedsDisplay()
    }
    
    private func highlightNode() {
        let centerY = bounds.height / 2.0
        
        let color = UIColor(hexString: "68A4D4")
        
        hightlightLayer.shadowColor = color.cgColor
        
        hightlightLayer.shadowPath = UIBezierPath(arcCenter: CGPoint(x: 12, y: centerY), radius: highlightRadius, startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true).cgPath
        
        hightlightLayer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        
        hightlightLayer.shadowOpacity = 0.4
        
        hightlightLayer.setNeedsDisplay()
    }
}
