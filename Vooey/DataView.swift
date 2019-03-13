//
//  DataView.swift
//  Vooey
//
//  Created by Blake Tsuzaki on 3/8/19.
//  Copyright © 2019 Modoki. All rights reserved.
//

import UIKit

protocol DataViewDelegate {
    func transcriptTapped()
}

class DataView: UIScrollView {
    var tapDelegate: DataViewDelegate?
    var data = [String]()
    var useEmptyState = false {
        didSet {
            dataBottom.isHidden = useEmptyState
        }
    }
    private let dataTop = UIImageView(named: "DataHeader")
    private let dataMid = TABubbleView()
    private let dataBottom = UIImageView(named: "InYourWords")
    private let noData = UILabel()
    private let yourWordsTapGesture = UITapGestureRecognizer()
    private var alreadyHasBubbles = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let views = [dataTop, dataMid, noData, dataBottom]
        addSubviews(views)
        
        let cardWidth = UIScreen.main.bounds.width
        let constraints = [
            dataTop.centerX(),
            dataTop.width(equalTo: cardWidth),
            dataTop.top(),
            dataTop.equalHeightWidth(multiplier: 160 / 824),
            
            dataMid.centerX(),
            dataMid.width(equalTo: cardWidth),
            dataMid.top(equalTo: dataTop, attribute: .bottom),
            dataMid.equalHeightWidth(multiplier: 2),
            
            noData.top(equalTo: dataMid),
            noData.left(equalTo: dataMid),
            noData.right(equalTo: dataMid),
            noData.height(equalTo: dataMid, attribute: .width),
            
            dataBottom.centerX(),
            dataBottom.width(equalTo: cardWidth),
            dataBottom.top(equalTo: dataMid, attribute: .bottom, spacing: -340),
            dataBottom.equalHeightWidth(multiplier: 1602 / 824),
        ]
        
        noData.text = "No data yet!"
        noData.textAlignment = .center
        
        activate(views: views,
                 constraints: constraints)
        
        layoutIfNeeded()
        
        let contentHeight = dataTop.frame.height + dataMid.frame.height + dataBottom.frame.height
        
        contentSize = CGSize(width: cardWidth, height: contentHeight)
        
        clipsToBounds = false
        showsVerticalScrollIndicator = false
        
        dataMid.backgroundColor = .white
        
        yourWordsTapGesture.addTarget(self, action: #selector(DataView.handleTranscriptTapped))
        dataBottom.addGestureRecognizer(yourWordsTapGesture)
    }
    
    @objc func handleTranscriptTapped() {
        tapDelegate?.transcriptTapped()
    }
    
    func addBubbles() {
        if data.count == 0 || alreadyHasBubbles { return }
        
        alreadyHasBubbles = true
        noData.isHidden = true
        
        for (i, item) in data.enumerated() {
            let randomStartX = max(CGFloat(arc4random_uniform(UInt32(self.frame.width))) - 120, 1)
            let origin = CGPoint(x: randomStartX, y: dataMid.width + CGFloat(arc4random_uniform(100)))
            let length = CGFloat(arc4random_uniform(50) + 80)
            let size = CGSize(width: length, height: length)
            let frame = CGRect(origin: origin, size: size)
            let view = TABubbleItem(frame: frame)
            
            view.backgroundColor = UIColor.lightGray
            view.text = item
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2 * Double(i)) {
                self.dataMid.add(view)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
