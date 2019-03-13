//
//  QuoteDeepView.swift
//  Vooey
//
//  Created by Blake Tsuzaki on 3/7/19.
//  Copyright © 2019 Modoki. All rights reserved.
//

import UIKit

class QuoteDeepView: UIScrollView {
    private let quoteCard = UIImageView(named: "QuoteDeep")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let views = [quoteCard]
        
        addSubviews(views)
        
        let cardWidth = UIScreen.main.bounds.width - 20
        let constraints = [
            quoteCard.centerX(),
            quoteCard.width(equalTo: cardWidth),
            quoteCard.top(),
            quoteCard.equalHeightWidth(multiplier: 1606 / 792),
        ]
        
        activate(views: views,
                 constraints: constraints)
        
        layoutIfNeeded()
        
        let contentHeight = quoteCard.frame.height
        
        contentSize = CGSize(width: cardWidth, height: contentHeight)
        
        clipsToBounds = false
        showsVerticalScrollIndicator = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
