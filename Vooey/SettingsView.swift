//
//  SettingsView.swift
//  Vooey
//
//  Created by Blake Tsuzaki on 3/8/19.
//  Copyright © 2019 Modoki. All rights reserved.
//

import UIKit

protocol SettingsViewDelegate {
    func tappedTranscript()
}

class SettingsView: UIScrollView {
    var tapDelegate: SettingsViewDelegate?
    var useEmptyState = false {
        didSet {
            settingsBottom.isHidden = useEmptyState
        }
    }
    
    private let settingsTop = UIImageView(named: "Settings-1")
    private let settingsBottom = UIImageView(named: "Settings-2")
    private let transcriptGesture = UITapGestureRecognizer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let views = [settingsTop, settingsBottom]
        
        addSubviews(views)
        
        let cardWidth = UIScreen.main.bounds.width
        let constraints = [
            settingsTop.centerX(),
            settingsTop.width(equalTo: cardWidth),
            settingsTop.top(),
            settingsTop.equalHeightWidth(multiplier: 1002 / 824),
            
            settingsBottom.centerX(),
            settingsBottom.width(equalTo: cardWidth),
            settingsBottom.top(equalTo: settingsTop, attribute: .bottom, spacing: -20),
            settingsBottom.equalHeightWidth(multiplier: 1592 / 824),
        ]
        
        activate(views: views,
                 constraints: constraints)
        
        layoutIfNeeded()
        
        let contentHeight = settingsTop.frame.height + settingsBottom.frame.height
        
        contentSize = CGSize(width: cardWidth, height: contentHeight)
        
        clipsToBounds = false
        showsVerticalScrollIndicator = false
        
        settingsTop.backgroundColor = .white
        
        transcriptGesture.addTarget(self, action: #selector(SettingsView.handleTranscriptTap))
        settingsBottom.addGestureRecognizer(transcriptGesture)
    }
    
    @objc func handleTranscriptTap() {
        tapDelegate?.tappedTranscript()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
