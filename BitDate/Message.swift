//
//  Message.swift
//  BitDate
//
//  Created by Jamie Montz on 5/7/15.
//  Copyright (c) 2015 David Montz. All rights reserved.
//

import Foundation

struct Message {
    let message: String
    let senderID: String
    let date: NSDate
}

private let ref = Firebase(url: " https://bitdatedmo.firebaseio.com/messages")
private let dateFormat = "yyyyMMddHHmmss"

private func dateFormatter () -> NSDateFormatter {
    
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = dateFormat
    return dateFormatter
}

func saveMessage (matchID: String, message: Message){
    ref.childByAppendingPath(matchID).updateChildValues([dateFormatter().stringFromDate(message.date) : ["message" : message.message, "sender" : message.senderID]])
}

func snapshotToMessage(snapshot: FDataSnapshot) -> Message {
    
    let date = dateFormatter().dateFromString(snapshot.key)
    let sender = snapshot.value["sender"] as? String
    let txt = snapshot.value["message"] as? String
    
    return Message(message: txt!, senderID: sender!, date: date!)
    
}

func fetchMessages (matchID: String, callback:([Message]) -> ()) {
    
    ref.childByAppendingPath(matchID).queryLimitedToFirst(25).observeSingleEventOfType(FEventType.Value, withBlock: {
        snapshot in
        var messages = Array<Message>()
        let enumerator = snapshot.children
        while let data = enumerator.nextObject() as? FDataSnapshot {
            messages.append(snapshotToMessage(data))
        }
        callback(messages)
    })
    
}