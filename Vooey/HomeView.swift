//
//  HomeView.swift
//  Vooey
//
//  Created by Blake Tsuzaki on 3/7/19.
//  Copyright © 2019 Modoki. All rights reserved.
//

import UIKit

protocol HomeViewDelegate {
    func handleQuoteTapped(frame: CGRect)
    func handleTipTapped()
}
class HomeView: UIScrollView {
    var tapDelegate: HomeViewDelegate?
    var topCardHidden: Bool = false {
        didSet { quoteCard.isHidden = topCardHidden }
    }
    var useEmptyState: Bool = false {
        didSet {
            quoteCard.isHidden = useEmptyState
            newsCard.isHidden = useEmptyState
            emptyCard.isHidden = !useEmptyState
        }
    }
    private let quoteCard = UIImageView(named: "QuoteCard")
    private let newsCard = UIImageView(named: "NewsCard")
    private let emptyCard = UIImageView(named: "EmptyState")
    
    private let quoteTapGesture = UITapGestureRecognizer()
    private let tipTapGesture = UITapGestureRecognizer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let views = [emptyCard, quoteCard, newsCard]
        
        addSubviews(views)
        
        let cardWidth = UIScreen.main.bounds.width - 20
        let constraints = [
            quoteCard.centerX(),
            quoteCard.width(equalTo: cardWidth),
            quoteCard.top(),
            quoteCard.equalHeightWidth(multiplier: 516 / 792),
            
            newsCard.centerX(),
            newsCard.width(equalTo: cardWidth),
            newsCard.top(equalTo: quoteCard,
                         attribute: .bottom,
                         spacing: 10),
            newsCard.equalHeightWidth(multiplier: 896 / 788),
            
            emptyCard.centerX(),
            emptyCard.width(equalTo: cardWidth),
            emptyCard.top(),
            emptyCard.equalHeightWidth(multiplier: 1296 / 792)
        ]
        
        activate(views: views,
                 constraints: constraints)
        
        layoutIfNeeded()
        
        let contentHeight = quoteCard.frame.height + newsCard.frame.height
        
        contentSize = CGSize(width: cardWidth, height: contentHeight)
        
        clipsToBounds = false
        showsVerticalScrollIndicator = false
        
        emptyCard.isHidden = true
        
        quoteTapGesture.addTarget(self, action: #selector(HomeView.handleQuoteTap))
        quoteCard.addGestureRecognizer(quoteTapGesture)
        
        tipTapGesture.addTarget(self, action: #selector(HomeView.handleTipTap))
        newsCard.addGestureRecognizer(tipTapGesture)
    }
    
    @objc func handleQuoteTap() {
        let quoteFrame = quoteCard.concreteFrame
        
        tapDelegate?.handleQuoteTapped(frame: quoteFrame)
    }
    
    @objc func handleTipTap() {
        tapDelegate?.handleTipTapped()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
