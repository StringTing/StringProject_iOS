//
//  STQAViewController.swift
//  st_ring
//
//  Created by EuiSuk_Lee on 2017. 9. 27..
//  Copyright © 2017년 EuiSuk_Lee. All rights reserved.
//

import UIKit
import Alamofire
import KRWordWrapLabel
import SwiftyJSON



struct message {
    let typeId : Int
    var text : String
}

struct basicInfo {
    var email : String?
    var password : String?
    var login_format : String?
    var birthday : String?
    var military_service_status : String?
    var education : String?
    var department : String?
    var location : String?
    var height : String?
    var body_form : String?
    var smoke : Bool?
    var drink : String?
    var religion : String?
    var blood_type : String?
    var authenticated : Bool?
    var id_image : String?
    
    func toDictionary() -> [String : Any]? {
        let prams = [
            "email" : self.email as Any,
            "password" : self.password as Any,
            "login_format" : self.login_format as Any,
            "birthday" : self.birthday as Any,
            "military_service_status" : self.military_service_status as Any,
            "education" : self.education as Any,
            "department" : self.department as Any,
            "location" : self.location as Any,
            "height" : self.height as Any,
            "body_form" : self.body_form as Any,
            "smoke" : self.smoke as Any,
            "drink" : self.drink as Any,
            "religion" : self.religion as Any,
            "blood_type" : self.blood_type as Any,
            "authenticated" : self.authenticated as Any,
            "id_image" : self.id_image as Any
            ] as [String : Any]
        
        return prams
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
    var userBasicInfo : basicInfo?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.backAction))
        self.navigationItem.leftBarButtonItem = newBackButton
        
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
            let textWidth : CGFloat = estimateFrameForText(QAMessage[indexPath.row].text).width + 20
            
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
            let textWidth : CGFloat = estimateFrameForText(QAMessage[indexPath.row].text).width
            cell.textView.text! = QAMessage[indexPath.row].text
            cell.bubbleWidthAnchor?.constant = textWidth
            return cell
        }
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height = CGFloat()
        
        if QAMessage[indexPath.row].typeId == 1{
            height = estimateFrameForText(QAMessage[indexPath.row].text).height + 50
        } else {
            height = estimateFrameForText(QAMessage[indexPath.row].text).height + 25
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
        Alamofire.request(self.server_domain, method: HTTPMethod.post, parameters: self.userBasicInfo?.toDictionary(), encoding: JSONEncoding.default, headers: nil).responseJSON{response in
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
        let cellsize = KRWordWrapLabel()
        cellsize.frame.size = CGSize(width: 230, height: 20)
        cellsize.text = text
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
        let indexPath = IndexPath(row: self.QAMessage.count-1, section: 0)
        self.chatView.scrollToRow(at: indexPath, at: .bottom, animated: true)
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
    
    func backAction() {
        let alert = UIAlertController(title: nil, message: "입력하신내용은 저장되지 않습니다. 되돌아가시겠습니까?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: {action in
            _ = self.navigationController?.popViewController(animated: true)
        }))
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}
