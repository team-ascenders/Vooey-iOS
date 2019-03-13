//
//  TABubbleItem.swift
//  Vooey
//
//  Created by Blake Tsuzaki on 3/5/19.
//  Copyright © 2019 Modoki. All rights reserved.
//

import UIKit

class TABubbleItem: UIView {
    var text: String? = nil {
        didSet {
            label.text = text
        }
    }
    override var collisionBoundsType: UIDynamicItemCollisionBoundsType {
        return .ellipse
    }
    private let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        var frame = bounds
        frame.origin.x = 10
        frame.size.width -= 20
        
        label.frame = frame
        label.textColor = .black
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        
        addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        layer.cornerRadius = rect.size.width / 2
        layer.masksToBounds = true
    }
}
