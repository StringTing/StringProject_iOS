//
//  STEmailLoginViewController.swift
//  st_ring
//
//  Created by euisuk_lee on 2017. 9. 17..
//  Copyright © 2017년 EuiSuk_Lee. All rights reserved.
//

import UIKit

class STEmailLoginViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var EmailText: UITextField!
    @IBOutlet weak var PasswordText: UITextField!
    @IBOutlet weak var EmailErrorLabel: UILabel!
    @IBOutlet weak var PasswordErrorLabel: UILabel!
    @IBOutlet weak var LoginBtn: UIButton!
    
    var emailCK : Bool!
    var passwordCK : Bool!
    
    var LoginBtnYLocation : CGFloat!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(STEmailJoinViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(STEmailJoinViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        EmailText.delegate = self
        PasswordText.delegate = self
        
        LoginBtn.isEnabled = false
        LoginBtn.backgroundColor? = UIColor.lightGray
        
        self.LoginBtnYLocation = self.LoginBtn.frame.origin.y

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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func LoginBtn(_ sender: Any) {
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField == self.EmailText && self.EmailText.text! != ""){
            isValidEmail(EmailStr: EmailText.text!)
            self.PasswordText.becomeFirstResponder()
        }else if(textField == self.PasswordText && self.PasswordText.text! != ""){
            isValidPassword(Password:PasswordText.text!)
        }
        
        if(EmailText.text! != "" && PasswordText.text! != ""){
            if(emailCK! == true && passwordCK! == true){
                LoginBtn.isEnabled = true
                LoginBtn.backgroundColor? = UIColor.black
            } else {
                LoginBtn.isEnabled = false
                LoginBtn.backgroundColor? = UIColor.lightGray
            }
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        if(textField == self.EmailText && self.EmailText.text! != ""){
            isValidEmail(EmailStr: EmailText.text!)
            self.PasswordText.becomeFirstResponder()
        }else if(textField == self.PasswordText && self.PasswordText.text! != ""){
            isValidPassword(Password:PasswordText.text!)
        }
        
        if(EmailText.text! != "" && PasswordText.text! != ""){
            if(emailCK! == true && passwordCK! == true){
                LoginBtn.isEnabled = true
                LoginBtn.backgroundColor? = UIColor.black
            } else {
                LoginBtn.isEnabled = false
                LoginBtn.backgroundColor? = UIColor.lightGray
            }
        }
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.LoginBtn.frame.origin.y == self.LoginBtnYLocation{
                self.LoginBtn.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.LoginBtn.frame.origin.y != self.LoginBtnYLocation{
                self.LoginBtn.frame.origin.y += keyboardSize.height
            }
        }
    }
    
    func isValidEmail(EmailStr:String) -> Void {
        print("validate emilId: \(EmailStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        if (emailTest.evaluate(with: EmailStr) == false) {
            EmailErrorLabel.text! = "이메일을 형식이 올바르지 않습니다."
            self.emailCK = false
        } else {
            EmailErrorLabel.text! = ""
            self.emailCK = true
        }
    }
    
    func isValidPassword(Password:String){
        self.passwordCK = true
    }
}
