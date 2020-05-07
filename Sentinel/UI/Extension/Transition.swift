//
//  Transition.swift
//  Sentinel
//
//  Created by Farzad Nazifi on 01.06.18.
//  Copyright © 2018 Samourai. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func transition(to containerView: UIView? = nil, duration: Double = 0.25, child: UIViewController, completion: ((Bool) -> Void)? = nil) {
        
        let container = ((containerView != nil) ? containerView! : view!)
        
        let current = children.last
        addChild(child)
        
        let newView = child.view!
        newView.translatesAutoresizingMaskIntoConstraints = true
        newView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        newView.frame = container.bounds
        
        func add() {
            container.addSubview(newView)
            
            UIView.animate(withDuration: duration, delay: 0, options: [.transitionCrossDissolve], animations: { }, completion: { done in
                child.didMove(toParent: self)
                completion?(done)
            })
        }
        
        if let existing = current {
            if existing == child {
                existing.willMove(toParent: nil)
                
                transition(from: existing, to: child, duration: duration, options: [.transitionCrossDissolve], animations: { }, completion: { done in
                    existing.removeFromParent()
                    child.didMove(toParent: self)
                    completion?(done)
                })
            }else{
                add()
            }
        } else {
            add()
        }
    }
}
