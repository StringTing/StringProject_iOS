//
//  STStartViewController.swift
//  st_ring
//
//  Created by EuiSuk_Lee on 2017. 8. 28..
//  Copyright © 2017년 EuiSuk_Lee. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore



class STStartViewController: UIViewController {
    @IBOutlet weak var StartLogoImg: UIImageView!
    @IBOutlet weak var agreeLabel: UILabel!
    @IBOutlet weak var emailLogin: UIButton!
    @IBOutlet weak var join: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        agreeLabel.text? = "가입하기 또는 로그인 버튼을 누르면 \n이용 약관 및 개인정보취급방침에 동의하신 것이 됩니다."
        agreeLabel.textAlignment = .center
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func FBLoginBtn(_ sender: Any) {
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
