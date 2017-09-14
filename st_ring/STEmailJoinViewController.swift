//
//  STEmailJoinViewController.swift
//  st_ring
//
//  Created by EuiSuk_Lee on 2017. 9. 14..
//  Copyright © 2017년 EuiSuk_Lee. All rights reserved.
//

import UIKit

class STEmailJoinViewController: UIViewController{
    @IBOutlet weak var EmailText: UITextField!
    @IBOutlet weak var PasswordText: UITextField!
    @IBOutlet weak var PWCheckText: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

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
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if(textField.isEqual(self.EmailText)){
            self.PasswordText.becomeFirstResponder()
        }else if(textField.isEqual(self.PasswordText)){
            self.PWCheckText.becomeFirstResponder()
        }
        return true
    }
    
    func endEdit(){
        self.PWCheckText.resignFirstResponder()
    }
    
    func isValidEmail(testStr:String) -> Bool {
        
        print("validate emilId: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluateWithObject(testStr)
        let result2 = EmailText.evalue
        return result
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
