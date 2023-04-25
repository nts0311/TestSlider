//
//  RankingLevelTextLayer.swift
//  TestSlider
//
//  Created by son on 25/04/2023.
//

import QuartzCore
import UIKit

class RankingLevelTextLayer: CALayer {
    
    var texts: [String] = []
    var colors: [UIColor] = []
    var font: UIFont = .systemFont(ofSize: 12, weight: .bold)
    
    var nodeSize: CGFloat = 12.0
    
    override func draw(in ctx: CGContext) {
        let centerY = bounds.height / 2.0
        
        var x = nodeSize
        let distanceBetweenNode = (bounds.width - nodeSize * 2.0) / CGFloat(texts.count - 1)
        for i in texts.indices {
            drawText(text: texts[i], center: CGPoint(x: x, y: centerY), color: colors[i])
            x += distanceBetweenNode
        }
    }
    
    private func drawText(text: String, center: CGPoint, color: UIColor) {
        let textLayer = CATextLayer()
        
        let textMaxWidth = 54.0
        let textMaxHeight = 36.0
        
        let textSize = text.sizeForFont(self.font)
        
        var textWidth = (textSize.width.rounded(.up) > textMaxWidth) ? textMaxWidth : textSize.width.rounded(.up)
        var textHeight = (textSize.width.rounded(.up) > textMaxWidth) ? textMaxHeight : textSize.height.rounded(.up) + 4.0
        
        let textX = center.x - textWidth / 2.0
        let textY = 36.0 / 2 - textHeight / 2.0
        
        textLayer.frame = CGRect(x: textX, y: textY, width: textWidth, height: textHeight)
        textLayer.font = font
        textLayer.fontSize = font.pointSize
       
        textLayer.foregroundColor = color.cgColor
        textLayer.contentsScale = UIScreen.main.scale
        textLayer.string = text
        textLayer.isWrapped = true
        textLayer.alignmentMode = .center
        
        
        //textLayer.borderWidth = 1
        //textLayer.borderColor = UIColor.black.cgColor
        
        addSublayer(textLayer)
    }
}

fileprivate extension String {
    func sizeForFont(_ font: UIFont, constraintHeight: CGFloat = .greatestFiniteMagnitude, constraintWidth: CGFloat = UIScreen.main.bounds.size.width) -> CGRect {
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        let attributedText = NSAttributedString(string: self, attributes: attributes)
        let constraintBox = CGSize(width: constraintWidth, height: constraintHeight)
        let textWidth = attributedText.boundingRect(with: constraintBox, options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
        return textWidth
    }
}
