//
//  STQAViewController.swift
//  st_ring
//
//  Created by EuiSuk_Lee on 2017. 9. 27..
//  Copyright © 2017년 EuiSuk_Lee. All rights reserved.
//

import UIKit

struct message {
    let typeId : Int
    var text : String
}

class STQAViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextViewDelegate {
    @IBOutlet weak var chatView: UITableView!
    @IBOutlet weak var inputbar: UIView!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var DoneButton: UIButton!
    @IBOutlet weak var inputTextView: UITextView!
    
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
    var QAMessage = [message]()
    var QuestionMessage = [message]()
    var currentEditMessage : IndexPath?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        chatView.delegate = self
        chatView.dataSource = self
        inputTextView.delegate = self
        self.QuestionType()
        QAMessage.append(message(typeId: 0, text: "안녕하세요! \n회원정보를 입력하시느라 고생많으셨어요~ \n이제 마지막 단계인데요! \n제가 하는 질문을 이상형인 사람이 질문한다고생각해주시고 정성스럽게 답장해주세요!"))
        QAMessage.append(QuestionMessage[0])

        self.chatView.register(MYEditTableViewCell.self, forCellReuseIdentifier: "MYEditTableViewCell")
        self.chatView.register(OtherTableViewCell.self, forCellReuseIdentifier: "OtherTableViewCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
            QuestionMessage.append(message(typeId: 0, text: i))
        }
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
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return QAMessage.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if QAMessage[indexPath.row].typeId == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MYEditTableViewCell", for: indexPath) as! MYEditTableViewCell
            let textWidth : CGFloat = estimateFrameForText(QAMessage[indexPath.row].text).width + 25
            
            cell.textView.text! = QAMessage[indexPath.row].text
            cell.editButton.tag = indexPath.row
            cell.editButton.addTarget(self, action: #selector(self.editButtonAction), for: .touchUpInside)
            if(textWidth > 100){
                cell.bubbleWidthAnchor?.constant = textWidth
            } else {
                cell.bubbleWidthAnchor?.constant = 100
                cell.textView.textAlignment = .center
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OtherTableViewCell", for: indexPath) as! OtherTableViewCell
            let textWidth : CGFloat = estimateFrameForText(QAMessage[indexPath.row].text).width + 25
            
            cell.textView.text! = QAMessage[indexPath.row].text
            if(textWidth > 100){
                cell.bubbleWidthAnchor?.constant = textWidth
            } else {
                cell.bubbleWidthAnchor?.constant = 100
            }
            return cell
        }
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height : CGFloat = 80
        
        if QAMessage[indexPath.row].typeId == 1{
            height = estimateFrameForText(QAMessage[indexPath.row].text).height + 65
        } else {
            height = estimateFrameForText(QAMessage[indexPath.row].text).height + 35
        }
        
        return height
    }
    
    public func textViewDidBeginEditing(_ textView: UITextView) {
        self.inputTextView.text = ""
        self.inputTextView.textColor = .black
    }
    
    @IBAction func sendAction(_ sender: Any) {
        if (self.sendButton.titleLabel?.text == "완료") {
            if let i = inputTextView.text {
                self.QAMessage[(currentEditMessage?.row)!].text = i
                self.inputTextView.text = ""
                self.chatView.reloadData()
            }
        } else {
            if let i = inputTextView.text {
                self.QAMessage.append(message(typeId: 1, text: i))
                self.inputTextView.text = ""
                self.chatView.reloadData()
            }
            questioner()
            self.chatView.reloadData()
        }
        
        if(QAMessage.count == 9) {
            self.DoneButton.backgroundColor = .black
            self.DoneButton.isHidden = false
        }
        
        scrollToBottom()
    }
    
    private func estimateFrameForText(_ text: String) -> CGRect {
        let size = CGSize(width: 200, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16)], context: nil)
    }
    
    func editButtonAction(sender : UIButton){
        if let cell = sender.superview?.superview?.superview as? MYEditTableViewCell {
            self.inputTextView.text = cell.textView.text
            self.sendButton.titleLabel?.text = "완료"
            self.currentEditMessage = chatView.indexPath(for: cell)
            self.DoneButton.isHidden = true
        }
    }
    
    func scrollToBottom(){
        DispatchQueue.global(qos: .background).async {
            let indexPath = IndexPath(row: self.QAMessage.count-1, section: 0)
            self.chatView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
}
