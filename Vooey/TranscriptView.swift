//
//  TranscriptView.swift
//  Vooey
//
//  Created by Blake Tsuzaki on 3/8/19.
//  Copyright © 2019 Modoki. All rights reserved.
//

import UIKit

protocol TranscriptViewDelegate {
    func deleteItem()
}

class TranscriptView: UIScrollView {
    var tapDelegate: TranscriptViewDelegate? {
        didSet {
            deleteButton.isHidden = tapDelegate != nil
        }
    }
    
    var hideDeleteButton = true {
        didSet {
            deleteButton.isHidden = hideDeleteButton
        }
    }
    
    private let quoteCard = UIImageView(named: "Transcript")
    private let deleteButton = UIImageView(named: "DeleteTranscript")
    private let deleteTapGesture = UITapGestureRecognizer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(quoteCard)
        quoteCard.addSubview(deleteButton)
        
        let cardWidth = UIScreen.main.bounds.width
        let constraints = [
            quoteCard.centerX(),
            quoteCard.width(equalTo: cardWidth),
            quoteCard.top(),
            quoteCard.equalHeightWidth(multiplier: 1592 / 824),
            
            deleteButton.centerX(),
            deleteButton.bottom(equalTo: quoteCard, spacing: -100),
            deleteButton.equalHeightWidth(multiplier: 72 / 404),
            deleteButton.width(equalTo: quoteCard, multiplier: 404 / 824)
        ]
        
        activate(views: [quoteCard, deleteButton],
                 constraints: constraints)
        
        layoutIfNeeded()
        
        let contentHeight = quoteCard.frame.height
        
        contentSize = CGSize(width: cardWidth, height: contentHeight)
        
        clipsToBounds = false
        showsVerticalScrollIndicator = false
        
        deleteTapGesture.addTarget(self, action: #selector(TranscriptView.handleDelete))
        deleteButton.addGestureRecognizer(deleteTapGesture)
        deleteButton.isHidden = true
    }
    
    @objc func handleDelete() {
        tapDelegate?.deleteItem()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
