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
        let user: User
    }
    
    let frontCardTopMargin: CGFloat = 0.0
    let backCardTopMargin: CGFloat = 10.0
    
    @IBOutlet weak var cardStackView: UIView!
    
    var backCard: Card?
    var frontCard: Card?
    
    var users: [User]?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.titleView = UIImageView(image: UIImage(named: "nav-header"))
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "nav-back-button"), style: UIBarButtonItemStyle.Plain, target: self, action: "goToProfile:")
        navigationItem.setLeftBarButtonItems([leftBarButtonItem], animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //cardStackView.backgroundColor = UIColor.blueColor()
        

        fetchUnviewedUsers({
            users in
            self.users = users
            
            if let card = self.popCard() {
                self.frontCard = card
                self.cardStackView.addSubview(self.frontCard!.swipView)
            }
            
            if let card = self.popCard() {
                self.backCard = card
                self.backCard!.swipView.frame = self.createCardFrame(self.backCardTopMargin)
                self.cardStackView.insertSubview(self.backCard!.swipView, belowSubview: self.frontCard!.swipView)
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func createCardFrame(topMargin: CGFloat) -> CGRect {
        return CGRect(x: 0, y: topMargin, width: cardStackView.frame.width, height: cardStackView.frame.height)
    }
    
    private func createCard (user: User) -> Card {
        let cardView = CardView()
        cardView.name = user.name
        user.getPhoto({
            image in
            cardView.image = image
        })
        
        let swipView = SwipeView(frame: createCardFrame(0))
        swipView.delegate = self
        swipView.innerView = cardView

        return Card(cardView: cardView, swipView: swipView, user:user)
    }
    
    private func popCard() -> Card? {
        if users != nil && users?.count > 0 {
            return createCard(users!.removeLast())
        }
        return nil
    }
    
    private func switchCard () {
        if let card = backCard {
            frontCard = card
            UIView.animateWithDuration(2, animations: {
                self.frontCard!.swipView.frame = self.createCardFrame(self.frontCardTopMargin)
            })
        }
        
        if let card = self.popCard() {
            self.backCard = card
            self.backCard!.swipView.frame = self.createCardFrame(self.backCardTopMargin)
            self.cardStackView.insertSubview(self.backCard!.swipView, belowSubview: self.frontCard!.swipView)
        }
    }
    
    //MARK:  SwipeViewDelegate
    func swipedLeft() {
        println("left")
    
        if let frontCard = self.frontCard {
            frontCard.swipView.removeFromSuperview()
            switchCard()
        }
    }
    
    func swipedRight() {
        println("right")
        
        if let frontCard = self.frontCard {
            frontCard.swipView.removeFromSuperview()
            switchCard()
        }
    }
    
    func goToProfile(button: UIBarButtonItem) {
        pageController.goToPreviousVC()
    }
}
