//
//  STEmailJoinViewController.swift
//  st_ring
//
//  Created by EuiSuk_Lee on 2017. 9. 14..
//  Copyright © 2017년 EuiSuk_Lee. All rights reserved.
//

import UIKit

class STEmailJoinViewController: UIViewController, UITextFieldDelegate{
    @IBOutlet weak var EmailText: UITextField!
    @IBOutlet weak var PasswordText: UITextField!
    @IBOutlet weak var PWCheckText: UITextField!
    @IBOutlet weak var JoinBtn: UIButton!
    @IBOutlet weak var EmailErrorLabel: UILabel!
    @IBOutlet weak var PWErrorLabel: UILabel!
    
    var emailCK : Bool!
    var passwordCK : Bool!
    var PWequalCK : Bool!
    
    var joinBtnYLocation : CGFloat!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(STEmailJoinViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(STEmailJoinViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        EmailText.delegate = self
        PasswordText.delegate = self
        PWCheckText.delegate = self
        
        JoinBtn.isEnabled = false
        
        self.joinBtnYLocation = self.JoinBtn.frame.origin.y
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.EmailText.becomeFirstResponder()
    }
    
    @IBAction func dismiss(_ sender: Any) {
        self.view.endEditing(true)
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if(textField == self.EmailText && self.EmailText.text! != ""){
            isValidEmail(EmailStr: EmailText.text!)
            self.PasswordText.becomeFirstResponder()
        }else if(textField == self.PasswordText && self.PasswordText.text! != ""){
            isValidPassword(Password: PasswordText.text!, CKPassword: PWCheckText.text!)
            self.PWCheckText.becomeFirstResponder()
        }else if(textField == self.PWCheckText && self.PWCheckText.text! != ""){
            isValidPassword(Password: PasswordText.text!, CKPassword: PWCheckText.text!)
        }
        
        if(EmailText.text! != "" && PasswordText.text! != "" && PWCheckText.text! != ""){
            if(emailCK! == true && passwordCK! == true && PWequalCK! ==  true){
                JoinBtn.isEnabled = true
            } else {
                JoinBtn.isEnabled = false
            }
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        
        if(textField == self.EmailText && self.EmailText.text! != ""){
            isValidEmail(EmailStr: EmailText.text!)
            self.PasswordText.becomeFirstResponder()
        }else if(textField == self.PasswordText && self.PasswordText.text! != ""){
            isValidPassword(Password: PasswordText.text!, CKPassword: PWCheckText.text!)
            
            self.PWCheckText.becomeFirstResponder()
        }else if(textField == self.PWCheckText && self.PWCheckText.text! != ""){
            isValidPassword(Password: PasswordText.text!, CKPassword: PWCheckText.text!)
        }
        
        if(EmailText.text! != "" && PasswordText.text! != "" && PWCheckText.text! != ""){
            if(emailCK! == true && passwordCK! == true && PWequalCK! ==  true){
                JoinBtn.isEnabled = true
            } else {
                JoinBtn.isEnabled = false
            }
        }
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.JoinBtn.frame.origin.y == self.joinBtnYLocation{
                self.JoinBtn.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.JoinBtn.frame.origin.y != self.joinBtnYLocation{
                self.JoinBtn.frame.origin.y += keyboardSize.height
            }
        }
    }
    
    func isValidEmail(EmailStr:String) -> Void {
        print("validate emilId: \(EmailStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        if (emailTest.evaluate(with: EmailStr) == false) {
            EmailErrorLabel.text! = "이메일을 형식이 올바르지 않습니다."
        } else {
            EmailErrorLabel.text! = ""
            self.emailCK = true
        }
    }
    
    func isValidPassword(Password : String, CKPassword : String) -> Void {
        let passwordRegEx = "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}"
        let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        
        if (passwordTest.evaluate(with: Password) == false) {
            PWErrorLabel.text! = "비밀번호는 영대/소문자, 숫자, 특수기호 혼합 8자리이상을 입력해주세요."
            self.passwordCK = false
        } else if (CKPassword != "" && Password != CKPassword){
            self.PWequalCK = false
            PWErrorLabel.text! = "비밀번호가 일치하지 않습니다."
        } else {
            PWErrorLabel.text! = ""
            self.passwordCK = true
            self.PWequalCK = true
        }
    }
    
    @IBAction func JoinAction(_ sender: Any) {
    }

}
