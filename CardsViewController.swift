//
//  CardsViewController.swift
//  BitDate
//
//  Created by Jamie Montz on 4/2/15.
//  Copyright (c) 2015 David Montz. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {

    let frontCardTopMargin: CGFloat = 0.0
    let backCardTopMargin: CGFloat = 10.0
    
    @IBOutlet weak var cardStackView: UIView!
    
    var backCard: SwipeView?
    var frontCard: SwipeView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cardStackView.backgroundColor = UIColor.clearColor()
        
        backCard = SwipeView(frame: createCardFrame(backCardTopMargin))
        cardStackView.addSubview(backCard!)
        frontCard = SwipeView(frame: createCardFrame(frontCardTopMargin))
        cardStackView.addSubview(frontCard!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func createCardFrame(topMargin: CGFloat) -> CGRect {
        return CGRect(x: 0, y: topMargin, width: cardStackView.frame.width, height: cardStackView.frame.height)
    }

}
