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
    var messageListener: MessageListener?
    
    override func viewDidLoad () {
        
        super.viewDidLoad()

        collectionView.collectionViewLayout.incomingAvatarViewSize = CGSizeZero
        collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSizeZero
        
        if let id = matchID {
            fetchMessages(id, {
                messages in
                
                for m in messages {
                    self.messages.append(JSQMessage(senderId: m.senderID, senderDisplayName: m.senderID, date: m.date, text: m.message))
                }
                self.finishReceivingMessage()
            })
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let id = matchID {
            messageListener = MessageListener(matchID: id, startDate: NSDate(), callback: {
                message in
                
                if (message.senderID != currentUser()?.id) {
                    
                    self.messages.append(JSQMessage(senderId: message.senderID, senderDisplayName: message.senderID, date: message.date, text: message.message))
                    self.finishReceivingMessage()
                }
            })
        }
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        messageListener?.stop()
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