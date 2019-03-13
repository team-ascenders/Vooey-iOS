//
//  TABubbleView.swift
//  Vooey
//
//  Created by Blake Tsuzaki on 3/5/19.
//  Copyright © 2019 Modoki. All rights reserved.
//

import UIKit

protocol TABubbleViewDelegate {
    func itemsDidCollide()
}

class TABubbleView: UIView {
    private var animator: UIDynamicAnimator?
    private let fieldBehavior = UIFieldBehavior.springField()
    private let collisionBehavior = UICollisionBehavior()
    private let dragBehavior = UIFieldBehavior.dragField()
    private let gravityBehavior = UIGravityBehavior()
    
    var gravityEnabled = false {
        didSet {
            guard let animator = animator else { return }
            if gravityEnabled {
                animator.removeBehavior(fieldBehavior)
                animator.addBehavior(gravityBehavior)
            } else {
                animator.removeBehavior(gravityBehavior)
                animator.addBehavior(fieldBehavior)
            }
        }
    }
    var delegate: TABubbleViewDelegate?

    override func layoutSubviews() {
        super.layoutSubviews()
        
        var position = center
        position.y = width / 2
        
        fieldBehavior.position = position
        fieldBehavior.region = UIRegion(size: bounds.size)
    }
    
    private func initAnimatorIfNeeded() {
        guard self.animator == nil else { return }
        
        let animator = UIDynamicAnimator(referenceView: self)
        animator.addBehavior(fieldBehavior)
        animator.addBehavior(collisionBehavior)
        
        let topLeft = CGPoint()
        let topRight = CGPoint(x: bounds.width, y: 0)
        let bottomRight = CGPoint(x: bounds.width, y: bounds.height)
        let bottomLeft = CGPoint(x: 0, y: bounds.height)

        collisionBehavior.addBoundary(withIdentifier: "left" as NSCopying,
                                      from: topLeft, to: bottomLeft)
//        collisionBehavior.addBoundary(withIdentifier: "bottom" as NSCopying,
//                                      from: bottomLeft, to: bottomRight)
        collisionBehavior.addBoundary(withIdentifier: "right" as NSCopying,
                                      from: bottomRight, to: topRight)
        collisionBehavior.addBoundary(withIdentifier: "top" as NSCopying,
                                      from: topRight, to: topLeft)
        
        collisionBehavior.collisionDelegate = self
        
        self.animator = animator
    }
    
    func add(_ item: UIView) {
        initAnimatorIfNeeded()
        addSubview(item)
        
        fieldBehavior.addItem(item)
        collisionBehavior.addItem(item)
        gravityBehavior.addItem(item)
    }
    
    func remove(_ item: UIView) {
        item.removeFromSuperview()
        
        fieldBehavior.removeItem(item)
        collisionBehavior.removeItem(item)
        gravityBehavior.removeItem(item)
    }
    
    func toggleGravity() {
        gravityEnabled = !gravityEnabled
    }
}

extension TABubbleView: UICollisionBehaviorDelegate {
    func collisionBehavior(_ behavior: UICollisionBehavior,
                           beganContactFor item1: UIDynamicItem,
                           with item2: UIDynamicItem,
                           at p: CGPoint) {
        delegate?.itemsDidCollide()
    }
    
    func collisionBehavior(_ behavior: UICollisionBehavior,
                           beganContactFor item: UIDynamicItem,
                           withBoundaryIdentifier identifier: NSCopying?,
                           at p: CGPoint) {
        delegate?.itemsDidCollide()
    }
}
