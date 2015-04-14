//
//  CardsViewController.swift
//  BitDate
//
//  Created by Jamie Montz on 4/2/15.
//  Copyright (c) 2015 David Montz. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController,SwipeViewDelegate {

    struct Card {
        let cardView: CardView
        let swipView: SwipeView
    }
    
    let frontCardTopMargin: CGFloat = 0.0
    let backCardTopMargin: CGFloat = 10.0
    
    @IBOutlet weak var cardStackView: UIView!
    
    var backCard: Card?
    var frontCard: Card?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.titleView = UIImageView(image: UIImage(named: "nav-header"))
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "nav-back-button"), style: UIBarButtonItemStyle.Plain, target: self, action: "goToProfile:")
        navigationItem.setLeftBarButtonItems([leftBarButtonItem], animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cardStackView.backgroundColor = UIColor.clearColor()
        
        backCard = createCard(backCardTopMargin)
        cardStackView.addSubview(backCard!.swipView)
        
        frontCard = createCard(frontCardTopMargin)
        cardStackView.addSubview(frontCard!.swipView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func createCardFrame(topMargin: CGFloat) -> CGRect {
        return CGRect(x: 0, y: topMargin, width: cardStackView.frame.width, height: cardStackView.frame.height)
    }
    
    private func createCard (topMargin: CGFloat) -> Card {
        let cardView = CardView()
        let swipView = SwipeView(frame: createCardFrame(topMargin))
        swipView.delegate = self
        swipView.innerView = cardView

        return Card(cardView: cardView, swipView: swipView)
    }
    
    //MARK:  SwipeViewDelegate
    func swipedLeft() {
        println("left")
    
        if let frontCard = self.frontCard {
            frontCard.swipView.removeFromSuperview()
        }
    }
    
    func swipedRight() {
        println("right")
        
        if let frontCard = self.frontCard {
            frontCard.swipView.removeFromSuperview()
        }
    }
    
    func goToProfile(button: UIBarButtonItem) {
        
    }
}
