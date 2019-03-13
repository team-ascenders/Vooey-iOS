//
//  TigerLayout.swift
//  Tiger
//
//  Created by Blake Tsuzaki on 3/2/17.
//  CopycenterY © 2017 Tigerr. All rights reserved.
//

import UIKit

enum TigerLayoutPriority {
    case now, eventually, whenever
}

extension UIView {
    var height: CGFloat { return bounds.height }
    var width: CGFloat { return bounds.width }
//    var top: CGFloat { return frame.origin.y }
    var bottom: CGFloat { return frame.origin.y + bounds.height }
//    var left: CGFloat { return frame.origin.x }
    var right: CGFloat { return frame.origin.x + bounds.width }

    var imageRepresentation: UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    var concreteFrame: CGRect {
        var tempView: UIView? = self
        var point = CGPoint()
        var frame = self.frame
        while let view = tempView {
            point.x += view.frame.origin.x
            point.y += view.frame.origin.y
            if let view = tempView as? UIScrollView {
                point.x -= view.contentOffset.x
                point.y -= view.contentOffset.y
            }
            tempView = view.superview
        }
        
        frame.origin = point
        return frame
    }
    
    func concreteFrame(in superview: UIView) -> CGRect {
        var tempView: UIView? = self
        var point = CGPoint()
        var frame = self.frame
        while let view = tempView, tempView != superview {
            point.x += view.frame.origin.x
            point.y += view.frame.origin.y
            if let view = tempView as? UIScrollView {
                point.x -= view.contentOffset.x
                point.y -= view.contentOffset.y
            }
            tempView = view.superview
        }
        
        frame.origin = point
        return frame
    }
    
    func equalHeightWidth(offset: CGFloat = 0) -> NSLayoutConstraint {
        return height(equalTo: self, attribute: .width, offset: offset)
    }
    func equalHeightWidth(multiplier: CGFloat) -> NSLayoutConstraint {
        return height(equalTo: self, attribute: .width, multiplier: multiplier)
    }
    func height(equalTo height: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: height)
    }
    func height(equalTo view: UIView, attribute: NSLayoutConstraint.Attribute = .height, offset: CGFloat = 0, multiplier: CGFloat = 1) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: view, attribute: attribute, multiplier: multiplier, constant: offset)
    }
    func width(equalTo width: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: width)
    }
    func width(equalTo view: UIView, attribute: NSLayoutConstraint.Attribute = .width, offset: CGFloat = 0, multiplier: CGFloat = 1) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: view, attribute: attribute, multiplier: multiplier, constant: offset)
    }
    private func printSuperviewNilError() {
        debugPrint("Warning: superview cannot be nil when creating a constraint constant")
    }
    func top(equalTo top: CGFloat = 0) -> NSLayoutConstraint {
        if superview == nil { printSuperviewNilError() }
        return NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: superview ?? self, attribute: .top, multiplier: 1.0, constant: top)
    }
    func top(equalTo view: UIView, attribute: NSLayoutConstraint.Attribute = .top, spacing: CGFloat = 0, multiplier: CGFloat = 1) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: view, attribute: attribute, multiplier: multiplier, constant: spacing)
    }
    func bottom(equalTo bottom: CGFloat = 0) -> NSLayoutConstraint {
        if superview == nil { printSuperviewNilError() }
        return NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: superview ?? self, attribute: .bottom, multiplier: 1.0, constant: bottom)
    }
    func bottom(equalTo view: UIView, attribute: NSLayoutConstraint.Attribute = .bottom, spacing: CGFloat = 0, multiplier: CGFloat = 1) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: attribute, multiplier: multiplier, constant: spacing)
    }
    func left(equalTo left: CGFloat = 0) -> NSLayoutConstraint {
        if superview == nil { printSuperviewNilError() }
        return NSLayoutConstraint(item: self, attribute: .left, relatedBy: .equal, toItem: superview ?? self, attribute: .left, multiplier: 1.0, constant: left)
    }
    func left(equalTo view: UIView, attribute: NSLayoutConstraint.Attribute = .left, spacing: CGFloat = 0) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self, attribute: .left, relatedBy: .equal, toItem: view, attribute: attribute, multiplier: 1.0, constant: spacing)
    }
    func right(equalTo right: CGFloat = 0) -> NSLayoutConstraint {
        if superview == nil { printSuperviewNilError() }
        return NSLayoutConstraint(item: self, attribute: .right, relatedBy: .equal, toItem: superview ?? self, attribute: .right, multiplier: 1.0, constant: right)
    }
    func right(equalTo view: UIView, attribute: NSLayoutConstraint.Attribute = .right, spacing: CGFloat = 0) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self, attribute: .right, relatedBy: .equal, toItem: view, attribute: attribute, multiplier: 1.0, constant: spacing)
    }
    func centerX(offset: CGFloat = 0) -> NSLayoutConstraint {
        if superview == nil { printSuperviewNilError() }
        return NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: superview ?? self, attribute: .centerX, multiplier: 1.0, constant: offset)
    }
    func centerX(equalTo view: UIView, attribute: NSLayoutConstraint.Attribute = .centerX, spacing: CGFloat = 0) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: attribute, multiplier: 1.0, constant: spacing)
    }
    func centerY(offset: CGFloat = 0) -> NSLayoutConstraint {
        if superview == nil { printSuperviewNilError() }
        return NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: superview ?? self, attribute: .centerY, multiplier: 1.0, constant: offset)
    }
    func centerY(equalTo view: UIView, attribute: NSLayoutConstraint.Attribute = .centerY, spacing: CGFloat = 0) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: attribute, multiplier: 1.0, constant: spacing)
    }
    
    func replace(_ constraint: inout NSLayoutConstraint?, with newConstraint: NSLayoutConstraint, priority: TigerLayoutPriority = .now) {
        if let constraint = constraint {
            constraint.isActive = false
            removeConstraint(constraint)
        }
        newConstraint.isActive = true
        
        switch priority {
        case .now: layoutIfNeeded()
        case .eventually: setNeedsLayout()
        case .whenever: break
        }
        
        constraint = newConstraint
    }
    
    func replace(_ constraints: inout [NSLayoutConstraint]?, with newConstraints: [NSLayoutConstraint], priority: TigerLayoutPriority = .now) {
        if let constraints = constraints {
            for constraint in constraints {
                constraint.isActive = false
                removeConstraint(constraint)
            }
        }
        for constraint in newConstraints {
            constraint.isActive = true
        }
        
        switch priority {
        case .now: layoutIfNeeded()
        case .eventually: setNeedsLayout()
        case .whenever: break
        }
        
        constraints = newConstraints
    }
    
    func disableAutoresizingMaskNonsense(views: [UIView]) {
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    func disableAutoresizingMaskNonsense(viewList: [String: UIView]) {
        disableAutoresizingMaskNonsense(views: Array(viewList.values))
    }
    func activate(viewList: [String: UIView], constraints: [NSLayoutConstraint], priority: TigerLayoutPriority = .eventually) {
        activate(views: Array(viewList.values), constraints: constraints, priority: priority)
    }
    func activate(viewList: [String: UIView], constraintList: [Any], priority: TigerLayoutPriority = .eventually) {
        activate(views: Array(viewList.values), constraintList: constraintList, priority: priority)
    }
    func activate(views: [UIView], constraints: [NSLayoutConstraint], priority: TigerLayoutPriority = .eventually) {
        disableAutoresizingMaskNonsense(views: views)
        NSLayoutConstraint.activate(constraints)
        
        switch priority {
        case .now: layoutIfNeeded()
        case .eventually: setNeedsLayout()
        case .whenever: break
        }
    }
    func activate(views: [UIView], constraintList: [Any], priority: TigerLayoutPriority = .eventually) {
        var constraints: [NSLayoutConstraint] = []
        for constraint in constraintList {
            if let constraint = constraint as? NSLayoutConstraint {
                constraints.append(constraint)
            } else if let constraintArr = constraint as? [NSLayoutConstraint] {
                for constraint in constraintArr {
                    constraints.append(constraint)
                }
            }
        }
        activate(views: views, constraints: constraints)
    }
    func deactivate(_ constraint: NSLayoutConstraint, priority: TigerLayoutPriority = .eventually) {
        constraint.isActive = false
        removeConstraint(constraint)
        
        switch priority {
        case .now: layoutIfNeeded()
        case .eventually: setNeedsLayout()
        case .whenever: break
        }
    }
    func deactivate(_ constraints: [NSLayoutConstraint], priority: TigerLayoutPriority = .eventually) {
        for constraint in constraints {
            constraint.isActive = false
            removeConstraint(constraint)
        }
        
        switch priority {
        case .now: layoutIfNeeded()
        case .eventually: setNeedsLayout()
        case .whenever: break
        }
    }
    func compoundConstraints(format: String, views: [String: UIView], metrics: [String: Any]? = nil) -> [NSLayoutConstraint] {
        return NSLayoutConstraint.constraints(withVisualFormat: format, options: [], metrics: metrics, views: views)
    }
    
    func addSubviews(_ views: Any) {
        var viewArr = [UIView]()
        
        if let views = views as? [UIView] {
            viewArr = views
        } else if let viewList = views as? [String: UIView] {
            viewArr = Array(viewList.values)
        }
        
        for view in viewArr { addSubview(view) }
    }
}

extension UIViewController {
    func replace(_ constraint: inout NSLayoutConstraint?, with newConstraint: NSLayoutConstraint, priority: TigerLayoutPriority = .now) {
        view.replace(&constraint, with: newConstraint, priority: priority)
    }
    func replace(_ constraints: inout [NSLayoutConstraint]?, with newConstraints: [NSLayoutConstraint], priority: TigerLayoutPriority = .now) {
        view.replace(&constraints, with: newConstraints, priority: priority)
    }
    func disableAutoresizingMaskNonsense(views: [UIView]) {
        view.disableAutoresizingMaskNonsense(views: views)
    }
    func disableAutoresizingMaskNonsense(viewList: [String: UIView]) {
        view.disableAutoresizingMaskNonsense(viewList: viewList)
    }
    func activate(viewList: [String: UIView], constraints: [NSLayoutConstraint], priority: TigerLayoutPriority = .eventually) {
        view.activate(viewList: viewList, constraints: constraints, priority: priority)
    }
    func activate(viewList: [String: UIView], constraintList: [Any], priority: TigerLayoutPriority = .eventually) {
        view.activate(viewList: viewList, constraintList: constraintList, priority: priority)
    }
    func activate(views: [UIView], constraints: [NSLayoutConstraint], priority: TigerLayoutPriority = .eventually) {
        view.activate(views: views, constraints: constraints, priority: priority)
    }
    func activate(views: [UIView], constraintList: [Any], priority: TigerLayoutPriority = .eventually) {
        view.activate(views: views, constraintList: constraintList, priority: priority)
    }
    func deactivate(_ constraint: NSLayoutConstraint, priority: TigerLayoutPriority = .eventually) {
        view.deactivate(constraint)
    }
    func deactivate(_ constraints: [NSLayoutConstraint], priority: TigerLayoutPriority = .eventually) {
        view.deactivate(constraints)
    }
    func compoundConstraints(format: String, views: [String: UIView], metrics: [String: Any]? = nil) -> [NSLayoutConstraint] {
        return view.compoundConstraints(format: format, views:views, metrics:metrics)
    }
}
