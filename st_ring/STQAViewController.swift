//
//  STQAViewController.swift
//  st_ring
//
//  Created by EuiSuk_Lee on 2017. 9. 27..
//  Copyright © 2017년 EuiSuk_Lee. All rights reserved.
//

import UIKit
import JSQMessagesViewController

struct QA {
    let id: String
    let name: String
}

class STQAViewController: JSQMessagesViewController {
    let Question = QA(id : "0", name : "Question")
    let Answer = QA(id : "1", name : "Answer")
    let QCase1 : [String] = [
        "CASE 1 Q1",
        "CASE 1 Q2",
        "CASE 1 Q3",
        "CASE 1 Q4"
        ]
    let QCase2 : [String] = [
        "CASE 2 Q1",
        "CASE 2 Q2",
        "CASE 2 Q3",
        "CASE 2 Q4"
    ]
    let QCase3 : [String] = [
        "CASE 3 Q1",
        "CASE 3 Q2",
        "CASE 3 Q3",
        "CASE 3 Q4"
    ]
    var randQuestion = [String]()
    var QAMessage = [JSQMessage]()
    var QuestionMessage = [JSQMessage]()
    var currentUser: QA {
        return Answer
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let introMessage = JSQMessage(senderId: "0", displayName: "Question", text : "안녕하세요! \n회원정보를 입력하시느라 고생많으셨어요~ \n 이제 마지막 단계인데요! \n제가 하는 질문을 이상형인 사람이 질문한다고생각해주시고 정성스럽게 답장해주세요!")
        
        self.senderId = currentUser.id
        self.senderDisplayName = currentUser.name
        self.inputToolbar.contentView.leftBarButtonItem = nil
        self.QAMessage.append(introMessage!)
        self.QuestionType()
        self.QAMessage.append(QuestionMessage[0])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        let message = JSQMessage(senderId: senderId, displayName: senderDisplayName, text: text)
        
        QAMessage.append(message!)
        questioner()
        finishSendingMessage()
    }
    
    func QuestionType (){
        let randomNum:UInt32 = arc4random_uniform(3)
        let someInt:Int = Int(randomNum)
        
        if(someInt == 0){
            self.randQuestion = self.QCase1
        } else if (someInt == 1){
            self.randQuestion = self.QCase2
        } else {
            self.randQuestion = self.QCase3
        }
        
        for i in self.randQuestion {
            let question = JSQMessage(senderId: "0", displayName: "Question", text: i)
            self.QuestionMessage.append(question!)
        }
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, attributedTextForMessageBubbleTopLabelAt indexPath: IndexPath!) -> NSAttributedString! {
        let QAMessage = self.QAMessage[indexPath.row]
        let messageUsername = QAMessage.senderDisplayName
        
        return NSAttributedString(string: messageUsername!)
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForMessageBubbleTopLabelAt indexPath: IndexPath!) -> CGFloat {
        return 15
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        return nil
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        let bubbleFactory = JSQMessagesBubbleImageFactory()
        
        let QAMessage = self.QAMessage[indexPath.row]
        
        if currentUser.id == QAMessage.senderId {
            return bubbleFactory?.outgoingMessagesBubbleImage(with: .green)
        } else {
            return bubbleFactory?.incomingMessagesBubbleImage(with: .black)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return QAMessage.count
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return QAMessage[indexPath.row]
    }
    
    func questioner() {
        if(QAMessage.count == 3) {
            QAMessage.append(QuestionMessage[1])
        } else if (QAMessage.count == 5) {
            QAMessage.append(QuestionMessage[2])
        } else if (QAMessage.count == 7) {
            QAMessage.append(QuestionMessage[3])
        } else {
            return
        }
    }
}
