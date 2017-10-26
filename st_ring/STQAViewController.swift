//
//  STQAViewController.swift
//  st_ring
//
//  Created by EuiSuk_Lee on 2017. 9. 27..
//  Copyright © 2017년 EuiSuk_Lee. All rights reserved.
//

import UIKit
import JSONJoy
import Alamofire



struct message {
    let typeId : Int
    var text : String
}

struct Answer : JSONJoy {
    let Answer1 : String
    let Answer2 : String
    let Answer3 : String
    let Answer4 : String
    
    init(_ decoder : JSONLoader) throws {
        Answer1 = try decoder["Answer1"].get()
        Answer2 = try decoder["Answer2"].get()
        Answer3 = try decoder["Answer3"].get()
        Answer4 = try decoder["Answer4"].get()
    }
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
    let server_domain = "http://115.68.226.54:3825"
    
    var randQuestion = [String]()
    var QAMessage = [message]()
    var QuestionMessage = [message]()
    var currentEditMessage : IndexPath?
    var inputBarYLocation : CGFloat?
    

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
        
        NotificationCenter.default.addObserver(self, selector: #selector(STQAViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(STQAViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        inputBarYLocation = self.inputbar.frame.origin.y
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        self.chatView.isUserInteractionEnabled = true
        self.chatView.addGestureRecognizer(tapGesture)
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
            let textWidth : CGFloat = estimateFrameForText(QAMessage[indexPath.row].text).width + 30
            
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
            let textWidth : CGFloat = estimateFrameForText(QAMessage[indexPath.row].text).width + 20
            cell.textView.text! = QAMessage[indexPath.row].text
            cell.bubbleWidthAnchor?.constant = textWidth
            return cell
        }
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height : CGFloat = 80
        
        if QAMessage[indexPath.row].typeId == 1{
            height = estimateFrameForText(QAMessage[indexPath.row].text).height + 50
        } else {
            height = estimateFrameForText(QAMessage[indexPath.row].text).height + 30
        }
        
        return height
    }
    
    public func textViewDidBeginEditing(_ textView: UITextView) {
        self.inputTextView.text = ""
        self.inputTextView.textColor = .black
    }
    
    public func textViewDidEndEditing(_ textView: UITextView) {
        if (self.inputTextView.text == "") {
            self.inputTextView.text = "질문에 응답해주세요! (5자 이상)"
            self.inputTextView.textColor = .lightGray
        }
    }
    
    public func textViewDidChange(_ textView: UITextView) {
        if (self.inputTextView.text == "") {
            self.inputTextView.text = "질문에 응답해주세요! (5자 이상)"
            self.inputTextView.textColor = .lightGray
        } else if (self.inputTextView.text == "질문에 응답해주세요! (5자 이상") {
            self.inputTextView.text = ""
            self.inputTextView.textColor = .black
        }
    }
    
    @IBAction func sendAction(_ sender: Any) {
        if (self.sendButton.titleLabel?.text == "완료") {
            if let i = inputTextView.text {
                self.QAMessage[(currentEditMessage?.row)!].text = i
                self.inputTextView.text = ""
                self.chatView.reloadData()
                self.sendButton.setTitle("전송", for: .normal)
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
        self.scrollToBottom()
    }
    
    @IBAction func doneAction(_ sender: Any) {
        let parameters = ["test" : "test"]
        Alamofire.request(self.server_domain, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON{response in
            switch response.result {
            case .success:
                print("Validation Successful")
            case .failure(let error):
                print("이것은 에러입니다 삐빅 :" + String(describing: error))
            }
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
        }
    }
    
    private func estimateFrameForText(_ text: String) -> CGSize {
        let cellsize = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        cellsize.text = text
        cellsize.preferredMaxLayoutWidth = 200
        cellsize.numberOfLines = 0
        cellsize.lineBreakMode = .byWordWrapping
        cellsize.font = UIFont.systemFont(ofSize: 14)
        cellsize.sizeToFit()
        
        return cellsize.frame.size
    }
    
    func editButtonAction(sender : UIButton){
        if let cell = sender.superview?.superview as? MYEditTableViewCell {
            self.inputTextView.text = cell.textView.text
            self.currentEditMessage = chatView.indexPath(for: cell)
            self.inputTextView.textColor = UIColor.black
            self.sendButton.setTitle("완료", for: .normal)
            self.DoneButton.isHidden = true
        }
    }
    
    func scrollToBottom(){
        //DispatchQueue.main.async {
            let indexPath = IndexPath(row: self.QAMessage.count-1, section: 0)
            self.chatView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        //}
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
            let window = self.view.window?.frame {
            // We're not just minusing the kb height from the view height because
            // the view could already have been resized for the keyboard before
            self.view.frame = CGRect(x: self.view.frame.origin.x,
                                     y: self.view.frame.origin.y,
                                     width: self.view.frame.width,
                                     height: window.origin.y + window.height - keyboardSize.height)
        } else {
            debugPrint("We're showing the keyboard and either the keyboard size or window is nil: panic widely.")
        }
        self.scrollToBottom()
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let viewHeight = self.view.frame.height
            self.view.frame = CGRect(x: self.view.frame.origin.x,
                                     y: self.view.frame.origin.y,
                                     width: self.view.frame.width,
                                     height: viewHeight + keyboardSize.height)
        } else {
            debugPrint("We're about to hide the keyboard and the keyboard size is nil. Now is the rapture.")
        }
    }
    
    func hideKeyboard() {
        self.view.endEditing(true)
    }
}
