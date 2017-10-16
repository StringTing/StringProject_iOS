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

class STQAViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var chatView: UITableView!
    @IBOutlet weak var inputbar: UIView!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        chatView.delegate = self
        chatView.dataSource = self
        self.QuestionType()
        QAMessage.append(message(typeId: 0, text: "안녕하세요! \n회원정보를 입력하시느라 고생많으셨어요~ \n 이제 마지막 단계인데요! \n제가 하는 질문을 이상형인 사람이 질문한다고생각해주시고 정성스럽게 답장해주세요!"))
        QAMessage.append(QuestionMessage[0])

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
            let cell = Bundle.main.loadNibNamed("MYEditTableViewCell", owner: self, options: nil)?.first as! MYEditTableViewCell
            cell.messageText.text! = QAMessage[indexPath.row].text
            cell.messageImg.image = UIImage(named: "defualt")!
            cell.editbutton.tag = indexPath.row
            return cell
        } else {
            let cell = Bundle.main.loadNibNamed("OtherTableViewCell", owner: self, options: nil)?.first as! OtherTableViewCell
            cell.messageText.text! = QAMessage[indexPath.row].text
            cell.messageImg.image = UIImage(named: "defualt")!
            return cell
        }
    }
    
    @IBAction func sendAction(_ sender: Any) {
        if let i = inputTextField.text {
            self.QAMessage.append(message(typeId: 1, text: i))
            self.inputTextField.text = ""
            self.chatView.reloadData()
        }
        questioner()
        self.chatView.reloadData()
    }
}
