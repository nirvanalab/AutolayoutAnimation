//
//  ViewController.swift
//  AutolayoutAnimation
//
//  Created by Nirvana on 10/4/17.
//  Copyright © 2017 Nirvana. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var menuHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var buttonMenu: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    var isMenuOpen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    @IBAction func onToggleMenu(_ sender: UIButton) {
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
        isMenuOpen = !isMenuOpen
        
        titleLabel.superview?.constraints.forEach { constraint in
            print(" -> \(constraint.description)\n")
            if constraint.firstItem === titleLabel &&
                constraint.firstAttribute == .centerX {
                constraint.constant = isMenuOpen ? -100.0 : 0.0
                return
            }
            
            if constraint.identifier == "TitleCenterY" {
                constraint.isActive = false
                //add new constraint
                let newConstraint = NSLayoutConstraint(
                    item: titleLabel,
                    attribute: .centerY,
                    relatedBy: .equal,
                    toItem: titleLabel.superview!,
                    attribute: .centerY,
                    multiplier: isMenuOpen ? 0.67 : 1.0,
                    constant: 5.0)
                newConstraint.identifier = "TitleCenterY"
                newConstraint.isActive = true
            }
        }

        
        menuHeightConstraint.constant = isMenuOpen ? 200.0 : 75.0
        titleLabel.text = isMenuOpen ? "Expanded View" : "Closed View"
        
        UIView.animate(withDuration: 1.0, delay: 0.0,
                       usingSpringWithDamping: 0.4, initialSpringVelocity: 10.0,
                       options: .curveEaseIn,
                       animations: {
                        
                        let angle: CGFloat = self.isMenuOpen ? .pi / 4 : 0.0
                        self.buttonMenu.transform = CGAffineTransform(rotationAngle: angle)
                        
                        //lays out the subviews
                        self.view.layoutIfNeeded()
        },
                       completion: nil
        )

    }
}

