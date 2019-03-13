//
//  FTUIView.swift
//  Vooey
//
//  Created by Blake Tsuzaki on 3/8/19.
//  Copyright © 2019 Modoki. All rights reserved.
//

import UIKit

protocol FTUIViewDelegate {
    func exitFtui()
}

class FTUIView: UIScrollView {
    var tapDelegate: FTUIViewDelegate?
    
    private let first = UIImageView(named: "FTUI-1")
    private let second = UIImageView(named: "FTUI-2")
    private let third = UIImageView(named: "FTUI-3")
    private let button = UIImageView(named: "DoneButton")
    private let buttonGesture = UITapGestureRecognizer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let views = [first, second, third, button]
        
        addSubviews(views)
        
        let cardWidth = UIScreen.main.bounds.width - 20
        let constraints = [
            first.top(),
            first.width(equalTo: cardWidth),
            first.equalHeightWidth(multiplier: 1296 / 792),
            first.left(equalTo: 10),

            second.top(),
            second.width(equalTo: cardWidth),
            second.equalHeightWidth(multiplier: 1296 / 792),
            second.left(equalTo: first, attribute: .right, spacing: 20),

            third.top(equalTo: 0),
            third.width(equalTo: cardWidth),
            third.equalHeightWidth(multiplier: 1296 / 792),
            third.left(equalTo: second,  attribute: .right, spacing: 20),
            third.right(equalTo: -10),
            
            button.centerX(equalTo: third),
            button.bottom(equalTo: third, spacing: -120),
            button.width(equalTo: third, multiplier: 192 / 792),
            button.equalHeightWidth(multiplier: 72 / 192)
        ]
        
        activate(views: views,
                 constraints: constraints)
        
        layoutIfNeeded()
        
        let contentWidth = first.frame.width + second.frame.width + third.frame.width
        
        contentSize = CGSize(width: contentWidth, height: height)
        
        clipsToBounds = false
        showsHorizontalScrollIndicator = false
        isPagingEnabled = true
        
        buttonGesture.addTarget(self, action: #selector(FTUIView.handleDoneButton))
        button.addGestureRecognizer(buttonGesture)
    }
    
    @objc func handleDoneButton() {
        tapDelegate?.exitFtui()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
