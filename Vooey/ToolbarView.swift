//
//  ToolbarView.swift
//  Vooey
//
//  Created by Blake Tsuzaki on 3/7/19.
//  Copyright © 2019 Modoki. All rights reserved.
//

import UIKit

enum VooeySection {
    case home, data, settings
}

protocol ToolbarViewDelegate {
    func showView(_ view: VooeySection)
    func fabTapped()
    func speechTapped()
    func keyTapped()
}

enum ToolbarViewType {
    case fab, nofab
}

class ToolbarView: UIView {
    var type: ToolbarViewType = .fab {
        didSet {
            if type == oldValue { return }
            if self.type == .fab {
                self.noFabToolbar.isHidden = true
                self.fabToolbar.isHidden = false
                self.fab.isHidden = false
            } else {
                self.noFabToolbar.isHidden = false
                self.fabToolbar.isHidden = true
                self.fab.isHidden = true
            }
        }
    }
    var delegate: ToolbarViewDelegate?
    var keyFabEnabled = false {
        didSet {
            if keyFabEnabled == oldValue { return }
            
            UIView.animate(withDuration: 0.2,
                           animations: {
                            let newConstraint = self.fab.top(equalTo: self.fabToolbar,
                                                             attribute: .bottom)
                            self.replace(&self.fabBottomConstraint, with: newConstraint)
            }) { (_) in
                self.fab.isHidden = self.keyFabEnabled
                self.keyFab.isHidden = !self.keyFabEnabled
                UIView.animate(withDuration: 0.2,
                               animations: {
                                let newConstraint = self.fab.bottom(equalTo: -19)
                                self.replace(&self.fabBottomConstraint, with: newConstraint)
                }, completion: nil)
            }
        }
    }
    
    private let fab = UIImageView(named: "fab")
    private let keyFab = UIImageView(named: "VooeyUIFab")
    private let noFabToolbar = UIImageView(named: "nofabtoolbar")
    private let fabToolbar = UIImageView(named: "fabtoolbar")
    private let homeButton = UIButton()
    private let dataButton = UIButton()
    private let settingsButton = UIButton()
    private let keyButton = UIButton()
    private let speechButton = UIButton()
    private let fabTapGesture = UITapGestureRecognizer()
    
    private var offset: CGFloat = 0
    private var fabToolbarBottomConstraint: NSLayoutConstraint?
    private var fabBottomConstraint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let views = [noFabToolbar,
                     fabToolbar,
                     fab,
                     keyFab,
                     homeButton,
                     dataButton,
                     settingsButton]
        let fabButtons = [keyButton,
                          speechButton]
        
        keyFab.addSubviews(fabButtons)
        addSubviews(views)
        
        let fabToolbarBottomConstraint = fabToolbar.bottom()
        self.fabToolbarBottomConstraint = fabToolbarBottomConstraint
        let fabBottomConstraint = fab.bottom(equalTo: -19)
        self.fabBottomConstraint = fabBottomConstraint
        
        let constraints = [
            noFabToolbar.left(),
            noFabToolbar.right(),
            noFabToolbar.bottom(),
            noFabToolbar.equalHeightWidth(multiplier: 124 / 836),
            
            fabToolbar.left(),
            fabToolbar.right(),
            fabToolbar.equalHeightWidth(multiplier: 124 / 836),
            fabToolbarBottomConstraint,
            
            fab.centerX(),
            fab.equalHeightWidth(),
            fab.width(equalTo: fabToolbar, multiplier: 152 / 836),
            fabBottomConstraint,
            
            keyFab.centerX(),
            keyFab.equalHeightWidth(multiplier: 110 / 270),
            keyFab.height(equalTo: fab),
            keyFab.centerY(equalTo: fab),
            
            keyButton.left(equalTo: keyFab),
            keyButton.top(equalTo: keyFab),
            keyButton.bottom(equalTo: keyFab),
            keyButton.width(equalTo: keyFab, multiplier: 0.5),
            
            speechButton.right(equalTo: keyFab),
            speechButton.top(equalTo: keyFab),
            speechButton.bottom(equalTo: keyFab),
            speechButton.width(equalTo: keyFab, multiplier: 0.5),
            
            homeButton.left(),
            homeButton.bottom(),
            homeButton.height(equalTo: fabToolbar),
            homeButton.equalHeightWidth(),
            
            dataButton.right(equalTo: settingsButton, attribute: .left),
            dataButton.bottom(),
            dataButton.height(equalTo: fabToolbar),
            dataButton.equalHeightWidth(),
            
            settingsButton.right(),
            settingsButton.bottom(),
            settingsButton.height(equalTo: fabToolbar),
            settingsButton.equalHeightWidth()
        ]
        
        homeButton.addTarget(self,
                             action: #selector(ToolbarView.homePressed),
                             for: .touchUpInside)
        dataButton.addTarget(self,
                             action: #selector(ToolbarView.dataPressed),
                             for: .touchUpInside)
        settingsButton.addTarget(self,
                                 action: #selector(ToolbarView.settingsPressed),
                                 for: .touchUpInside)
        keyButton.addTarget(self,
                            action: #selector(ToolbarView.keyPressed),
                            for: .touchUpInside)
        
        speechButton.addTarget(self,
                               action: #selector(ToolbarView.speechPressed),
                               for: .touchUpInside)
        
        activate(views: views + fabButtons, constraints: constraints)
        
        noFabToolbar.isHidden = true
        keyFab.isHidden = true
        
        fabTapGesture.addTarget(self, action: #selector(ToolbarView.fabPressed))
        fab.addGestureRecognizer(fabTapGesture)
    }
    
    @objc func keyPressed() {
        delegate?.keyTapped()
    }
    
    @objc func speechPressed() {
        delegate?.speechTapped()
    }
    
    @objc func fabPressed() {
        delegate?.fabTapped()
    }
    
    @objc func homePressed() {
        delegate?.showView(.home)
    }
    
    @objc func dataPressed() {
        delegate?.showView(.data)
    }
    
    @objc func settingsPressed() {
        delegate?.showView(.settings)
    }
    
    func updateForOffset(_ offset: CGFloat) {
        var newOffset = offset * 0.5

        newOffset = max(newOffset, 0)
        newOffset = min(newOffset, fabToolbar.height)
        
        let fabOffset = min(newOffset, 15)
        
        let newToolbarConstraint = fabToolbar.bottom(equalTo: newOffset)
        let newFabConstraint = fab.bottom(equalTo: fabOffset - 19)
        
        replace(&fabToolbarBottomConstraint, with: newToolbarConstraint)
        replace(&fabBottomConstraint, with: newFabConstraint)
        layoutIfNeeded()
        
        self.offset = newOffset
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
