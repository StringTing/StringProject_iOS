//
//  STLoginViewController.swift
//  st_ring
//
//  Created by euisuk_lee on 2017. 9. 17..
//  Copyright © 2017년 EuiSuk_Lee. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore

class STLoginViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func FBLogin(_ sender: Any) {
        let loginManager = LoginManager()
        
        loginManager.logIn([ .publicProfile ], viewController: self) { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success( _, _, _):
                print("Logged in!")
            }
        }
    }
    
    @IBAction func KakaoLogin(_ sender: Any) {
        let session = KOSession.shared()
        
        if let s = session {
            if s.isOpen(){
                s.close()
            }
            s.open(completionHandler: { (error) in
                if error == nil {
                    print("No error")
                    
                    if s.isOpen(){
                        print("Success")
                    }else {
                        print("Faild")
                    }
                }
                else {
                    print("Error login : \(error!)")
                }
            })
        }
        else {
            print("Something wrong")
        }
    }
    
    @IBAction func EmailLogin(_ sender: Any) {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "STEmailLoginViewController") as! STEmailLoginViewController
        self.present(vc, animated: true, completion: nil)
    }
    
}
