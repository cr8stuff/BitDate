//
//  ChatViewController.swift
//  BitDate
//
//  Created by Jamie Montz on 5/7/15.
//  Copyright (c) 2015 David Montz. All rights reserved.
//

import Foundation

class ChatViewController : JSQMessagesViewController {
    
    var messages: [JSQMessage] = []
    let outgoingBubble = JSQMessagesBubbleImageFactory().outgoingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleBlueColor())
    let incomingBubble = JSQMessagesBubbleImageFactory().incomingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleLightGrayColor())
    var matchID: String?
    
    override func viewDidLoad () {
        
        super.viewDidLoad()

        collectionView.collectionViewLayout.incomingAvatarViewSize = CGSizeZero
        collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSizeZero
    
    }
    
    func senderDisplayName() -> String {
        return currentUser()!.id
    }
    
    func senderId() -> String {
        return currentUser()!.id
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
        
        var data = self.messages[indexPath.row]
        return data
        
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageBubbleImageDataSource! {
        
        var data = self.messages[indexPath.row]
        
        if data.senderId == PFUser.currentUser().objectId {
            return outgoingBubble
        }
        else {
            return incomingBubble
        }
        
    }
    
    override func didPressSendButton(button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: NSDate!) {
        let m = JSQMessage(senderId: senderId, senderDisplayName: senderDisplayName, date: date, text: text)
        self.messages.append(m)
        
        if let id = matchID {
            saveMessage(id, Message(message: text, senderID: senderId, date: date))
        }
        
        finishSendingMessageAnimated(true)
    }
    
    
}