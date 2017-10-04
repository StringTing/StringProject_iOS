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
        "왜 그 일 하냐?",
        "전공은 뭐냐",
        "부모님은 뭐하시냐",
        "금수저냐?"
        ]
    let QCase2 : [String] = [
        "여혐 함?",
        "역시 여자는 추석엔 전을 부쳐야지",
        "당연히 시댁을 늦게 가야하는거 아니야?",
        "남자들이 운전하는걸 감사히 생각해야지;;;"
    ]
    let QCase3 : [String] = [
        "넌 이상형이 뭐냐?",
        "주말엔 뭐하냐",
        "뭐 음식 가리는거 있음?",
        "영화는 어떤 장르?"
    ]
    let introMessage = JSQMessage(senderId: "0", displayName: "Question", text : "안녕하세요! \n회원정보를 입력하시느라 고생많으셨어요~ \n 이제 마지막 단계인데요! \n제가 하는 질문을 이상형인 사람이 질문한다고생각해주시고 정성스럽게 답장해주세요!")
    var randQuestion = [String]()
    var QAMessage = [JSQMessage]()
    var QuestionMessage = [JSQMessage]()
    var currentUser: QA {
        return Answer
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
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
}
