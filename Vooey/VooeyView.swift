//
//  VooeyView.swift
//  Vooey
//
//  Created by Blake Tsuzaki on 3/8/19.
//  Copyright © 2019 Modoki. All rights reserved.
//

import UIKit

class VooeyView: UIScrollView {
    var speechEnabled = false {
        didSet {
            if (speechEnabled) {
                let pulseAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
                pulseAnimation.fromValue = 1
                pulseAnimation.toValue = 0
                
                let scaleAnimation:CABasicAnimation = CABasicAnimation(keyPath: "transform.scale")
                scaleAnimation.toValue = 1.2;
                scaleAnimation.fromValue = 0;
                
                let groupAnimation = CAAnimationGroup()
                groupAnimation.animations = [pulseAnimation, scaleAnimation]
                groupAnimation.duration = 5
                groupAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
                groupAnimation.repeatCount = .greatestFiniteMagnitude
                
                innerCircle.layer.cornerRadius = innerCircle.width / 2
                
                circle.layer.cornerRadius = circle.width / 2
                circle.layer.add(groupAnimation, forKey: "animateOpacity")
                circle.isHidden = false
                innerCircle.isHidden = false
                quoteCard.isHidden = true
            } else {
                circle.isHidden = true
                innerCircle.isHidden = true
                quoteCard.isHidden = false
                
                circle.layer.removeAllAnimations()
            }
            
            PubNubCoordinator.shared.shouldPlayAudio = speechEnabled
        }
    }
    private let quoteCard = UIImageView(named: "VooeyUI")
    private let circle = UIView()
    private let innerCircle = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let views = [quoteCard, circle, innerCircle]
        
        addSubviews(views)
        
        let cardWidth = UIScreen.main.bounds.width - 40
        let constraints = [
            quoteCard.centerX(),
            quoteCard.width(equalTo: cardWidth),
            quoteCard.top(),
            quoteCard.equalHeightWidth(multiplier: 554 / 644),
            
            circle.centerX(),
            circle.equalHeightWidth(),
            circle.width(equalTo: self, multiplier: 1),
            circle.centerY(),
            
            innerCircle.centerX(),
            innerCircle.centerY(),
            innerCircle.equalHeightWidth(),
            innerCircle.width(equalTo: circle, multiplier: 0.5)
        ]
        
        activate(views: views,
                 constraints: constraints)
        
        layoutIfNeeded()
        
        circle.isHidden = true
        circle.layer.masksToBounds = true
        circle.backgroundColor = .lightGray
        
        innerCircle.isHidden = true
        innerCircle.backgroundColor = .white
        innerCircle.layer.masksToBounds = true
        
        let contentHeight = quoteCard.frame.height
        
        contentSize = CGSize(width: cardWidth, height: contentHeight)
        
        clipsToBounds = false
        showsVerticalScrollIndicator = false
        alwaysBounceVertical = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
